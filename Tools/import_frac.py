import os
import time
import json
import multiprocessing
import math
from parse import parse
import formula2png
import hashlib

def parse_string(chain):
    result = parse("{numerator}_{denominator}.png", chain)
    try:
        numerator = int(result["numerator"])
        denominator = int(result["denominator"])
        return frozenset([(numerator, denominator, chain)])
    except:
        return frozenset()

def parse_answer(dict):
    frac_string = dict["text"]
    return parse_string(frac_string)

def parse_question(dict):
    question = dict["question"]
    fractions = frozenset()
    for i in question:
        fractions |= parse_string(i)

    answers = dict["answers"]
    for i in answers:
        fractions |= parse_answer(i)
    return fractions

def parse_topic(dict):
    questions = dict["questions"]
    fractions = frozenset()
    for i in questions:
        fractions |= parse_question(i)
    return fractions

def parse_file(array):
    fractions = frozenset()
    for i in array:
        fractions |= parse_topic(i)
    return fractions

def get_json_from_file(fileName):
    file = open(fileName, "r")
    fileContent = file.read()
    file.close()

    # Compute hash
    m = hashlib.md5()
    m.update(fileContent)

    return json.loads(fileContent), m.hexdigest()

def generate_fractions(fractions, dstFolder, globalCounter):
    for i,(numerator,denominator, fileName) in enumerate(fractions):
        # Generation the image
        formula2png.generate_fraction(numerator, denominator, fileName, dstFolder, verbose=False)
        # Increment the global counter
        with globalCounter.get_lock():
            globalCounter.value += 1

def create_processi(processusCount, fractions, dstFolder, counter):
    processi = []
    fractionCount = len(fractions)
    baseFractionPerProcessus = fractionCount / processusCount
    remainingFractionCount = fractionCount % processusCount
    print("Distributing %d fractions generation over %d processi" % (fractionCount, processusCount))

    startIndex = 0
    for i in range(processusCount):
        endIndex = min(startIndex + baseFractionPerProcessus, fractionCount)
        if (i < remainingFractionCount):
            endIndex += 1
        subRange = fractions[startIndex:endIndex]

        print("Processus %d will compute fractions from index %d to %d:" % (i, startIndex, endIndex - 1))
        processi += [multiprocessing.Process(target=generate_fractions, args=(subRange, dstFolder, counter))]
        startIndex = endIndex

    return processi

def launch_processi(processi):
    for processus in processi:
        processus.start()

def wait_processi(processi):
    for processus in processi:
        processus.join()

def get_digit_count(n):
    return int(math.log10(n))+1

def is_same_hash(currentHash, filePath):
    if os.path.exists(hashFilePath):
        with open(hashFilePath, 'r') as hashFile:
            previousHash = hashFile.read()
            return currentHash == previousHash
    return False

def write_hash(hash, filePath):
    with open(filePath, 'w') as hashFile:
        hashFile.write(hash)

if __name__ == '__main__':
    fileName = "fraction.txt"
    print("Reading data from '%s'" % fileName)
    json, hash = get_json_from_file(fileName)

    hashFileName = "hash.md5"
    hashFilePath = os.path.join(dst_folder, hashFileName)
    if (is_same_hash(hash, hashFilePath)):
        print("Nothing to do")
        exit(0)

    print("Parsing fractions ...")
    fractions = list(parse_file(json))
    fractionCount = len(fractions)

    dst_folder = "Fractions"
    if not os.path.exists(dst_folder):
        os.makedirs(dst_folder)

    globalCounter = multiprocessing.Value('i', 0)
    processi = create_processi(multiprocessing.cpu_count(), fractions, dst_folder, globalCounter)
    launch_processi(processi)

    progressFormat = "[%%3d%%%%] %%%dd / %%d images generated" % get_digit_count(fractionCount)
    while (globalCounter.value < fractionCount):
        time.sleep(0.1)
        print(progressFormat % (int(100 * globalCounter.value / fractionCount), globalCounter.value, fractionCount))
    wait_processi(processi)

    write_hash(hash, hashFilePath)




















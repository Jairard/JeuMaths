import json
from parse import parse
import frac2png

def parse_string(chain):
    result = parse("{numerator}_{denominator}.png", chain)
    try:
        numerator = int(result["numerator"])
        denominator = int(result["denominator"])
        return frozenset([(numerator, denominator, chain)])
    except:
        print (chain)
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

if __name__ == '__main__':
    fileName = "fraction.txt"
    print("Reading data from '%s'" % fileName)
    json = get_json_from_file(fileName)
    print("Parsing fractions ...")
    fractions = list(parse_file(json))
    fractionCount = len(fractions)

    dst_folder = "Fractions"
    if not os.path.exists(dst_folder):
        os.makedirs(dst_folder)





















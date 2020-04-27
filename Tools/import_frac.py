import json
from parse import parse
import frac2png

dict= []
frac = []
chain = ".png"

file = open("Godot_Fractions.txt", "r")
dict = file.read()
file.close
frac = json.loads(dict)

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

fractions = parse_file(frac)
for i,(numerator,denominator, file_name) in enumerate(fractions):
    print("%d / %d" % (i + 1, len(fractions)))
    frac2png.generate_fraction(numerator, denominator, file_name, "Fractions")





















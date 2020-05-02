import matplotlib.pyplot as plt
import io
import sys
import os
import imageUtils
import numpy

def render_latex(formula, fontsize=12, dpi=300, format_='png', pad_inches=0.0):
    fig = plt.figure(figsize=(0.01, 0.01))
    fig.text(0, 0, u'${}$'.format(formula), fontsize=fontsize)
    buffer_ = io.BytesIO()
    fig.savefig(buffer_, dpi=dpi, transparent=True, format=format_, bbox_inches='tight', pad_inches=pad_inches)
    plt.close(fig)
    return buffer_.getvalue()

def generate_formula(formula, file_name, dst_folder = ".", verbose = True, padding=0):
    file_path = os.path.join(dst_folder, file_name)
    tmp_file_path = "tmp_%s.png" % formula.replace('\\', '')
    if (verbose):
        print("Saving formula %s to '%s'..." % (formula, file_path))

    image_bytes = render_latex(formula, fontsize=10, dpi=300, format_='png', pad_inches=0.025)

    with open(tmp_file_path, 'wb') as image_file:
        image_file.write(image_bytes)

    with open(tmp_file_path, 'rb') as image_file:
        img = imageUtils.read_image_from_file(image_file)
        top, bot, left, right = imageUtils.count_alpha_padding(img)
        img2 = imageUtils.create_image_subregion(img, top, bot, left, right, padding=padding)

    os.remove(tmp_file_path)

    imageUtils.write_image(numpy.array(img), file_path)
    if (verbose):
        print("Done !")
        sys.stdout.flush()

def generate_fraction(numerator, denominator, file_name, dst_folder = ".", verbose = True, padding=0):
    formula = r"\frac{%d}{%d}" % (numerator, denominator)
    generate_formula(formula, file_name, dst_folder, verbose, padding)

def generate_exponent(number, exponent, file_name, dst_folder = ".", verbose = True, padding=0):
    formula = r"{%d}^{%d}" % (number, exponent)
    generate_formula(formula, file_name, dst_folder, verbose, padding)

def generate_double_exponent(number, first_exponent, second_exponent, file_name, dst_folder = ".", verbose = True, padding=0):
    formula = r"{%d}^{{%d}^{%d}}" % (number, first_exponent, second_exponent)
    generate_formula(formula, file_name, dst_folder, verbose, padding)

if __name__ == '__main__':
    numerator = int(sys.argv[1])
    denominator = int(sys.argv[2])
    fileName = "%d_%d.png" % (numerator, denominator)
    generate_fraction(numerator, denominator, fileName)

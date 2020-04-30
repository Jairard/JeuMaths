import matplotlib.pyplot as plt
import io
import sys
import os

def render_latex(formula, fontsize=12, dpi=300, format_='png', pad_inches=0.0):
    fig = plt.figure(figsize=(0.01, 0.01))
    fig.text(0, 0, u'${}$'.format(formula), fontsize=fontsize)
    buffer_ = io.BytesIO()
    fig.savefig(buffer_, dpi=dpi, transparent=True, format=format_, bbox_inches='tight', pad_inches=pad_inches)
    plt.close(fig)
    return buffer_.getvalue()

def generate_formula(formula, file_name, dst_folder = ".", verbose = True, pad_inches=0.0):
    file_path = os.path.join(dst_folder, file_name)
    if (verbose):
        print("Saving formula %s to '%s'..." % (formula, file_path))

    image_bytes = render_latex(formula, fontsize=10, dpi=300, format_='png', pad_inches=pad_inches)
    with open(file_path, 'wb') as image_file:
        image_file.write(image_bytes)
        if (verbose):
            print("Done !")

    if (verbose):
        sys.stdout.flush()

def generate_fraction(numerator, denominator, file_name, dst_folder = ".", verbose = True):
    formula = r"\frac{%d}{%d}" % (numerator, denominator)
    generate_formula(formula, file_name, dst_folder, verbose)

def generate_exponent(number, exponent, file_name, dst_folder = ".", verbose = True):
    formula = r"{%d}^{%d}" % (number, exponent)
    generate_formula(formula, file_name, dst_folder, verbose, pad_inches=0.025)

if __name__ == '__main__':
    numerator = int(sys.argv[1])
    denominator = int(sys.argv[2])
    fileName = "%d_%d.png" % (numerator, denominator)
    generate_fraction(numerator, denominator, fileName)

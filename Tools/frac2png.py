import matplotlib.pyplot as plt
import io
import sys
import os

def render_latex(formula, fontsize=12, dpi=300, format_='png'):
    fig = plt.figure(figsize=(0.01, 0.01))
    fig.text(0, 0, u'${}$'.format(formula), fontsize=fontsize)
    buffer_ = io.BytesIO()
    fig.savefig(buffer_, dpi=dpi, transparent=True, format=format_, bbox_inches='tight', pad_inches=0.0)
    plt.close(fig)
    return buffer_.getvalue()

def generate_fraction(numerator, denominator, file_name, dst_folder = "."):

    formula = r"\frac{%d}{%d}" % (numerator, denominator)

    file_path = os.path.join(dst_folder, file_name)
    print("Saving fraction %d/%d to '%s'..." % (numerator, denominator, file_path))

    image_bytes = render_latex(formula, fontsize=10, dpi=300, format_='png')
    if not os.path.exists(dst_folder):
        os.makedirs(dst_folder)
    with open(file_path, 'wb') as image_file:
        image_file.write(image_bytes)
        print("Done !")

    sys.stdout.flush()
if __name__ == '__main__':
    numerator = int(sys.argv[1])
    denominator = int(sys.argv[2])
    fileName = "%d_%d.png" % (numerator, denominator)
    generate_fraction(numerator, denominator, fileName)

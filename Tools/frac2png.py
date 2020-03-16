import matplotlib.pyplot as plt
import io
import sys

def render_latex(formula, fontsize=12, dpi=300, format_='png'):
    fig = plt.figure(figsize=(0.01, 0.01))
    fig.text(0, 0, u'${}$'.format(formula), fontsize=fontsize)
    buffer_ = io.BytesIO()
    fig.savefig(buffer_, dpi=dpi, transparent=True, format=format_, bbox_inches='tight', pad_inches=0.0)
    plt.close(fig)
    return buffer_.getvalue()

raw_numerator = float(sys.argv[1])
raw_denominator = float(sys.argv[2])
decimal_count = int(sys.argv[3]) if len(sys.argv) > 3 else 0

float_fmt = "%." + str(decimal_count) + "f"
numerator = float_fmt % raw_numerator
denominator = float_fmt % raw_denominator

formula = r"\frac{%s}{%s}" % (numerator, denominator)
output_file_name = "frac_%s_%s.png" % (raw_numerator, raw_denominator)

print("Saving fraction %s/%s to '%s'..." % (numerator, denominator, output_file_name))

image_bytes = render_latex(formula, fontsize=10, dpi=300, format_='png')
with open(output_file_name, 'wb') as image_file:
    image_file.write(image_bytes)
    print("Done !")

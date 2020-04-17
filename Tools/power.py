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



numerator = int(sys.argv[1])
denominator = int(sys.argv[2])

for i in range(-numerator, numerator + 1, 1):
    if i == 0 :
        continue
    for j in range(-denominator, denominator + 1, 1):
        if j == 0 :
            continue

        formula = r"%s^{%s}" % (i, j)
        output_file_name = "%s_____%s.png" % (i, j)

        print("Saving fraction %s/%s to '%s'..." % (i, j, output_file_name))

        image_bytes = render_latex(formula, fontsize=10, dpi=300, format_='png')
        with open(output_file_name, 'wb') as image_file:
            image_file.write(image_bytes)
            print("Done !")
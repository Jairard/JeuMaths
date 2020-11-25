import matplotlib.image as img
import matplotlib._png as png

def read_image_from_file(fileName):
    return img.imread(fileName)

def write_image(image, fileName):
    img.imsave(fileName, image)

def is_pixel_transparant(pixel):
    return (pixel[3] == 0)

def is_row_transparant(row):
    for pixel in row:
        if (not is_pixel_transparant(pixel)):
            return False
    return True

def is_column_transparant(image, lineIndex):
    for row in image:
        if (not is_pixel_transparant(row[lineIndex])):
            return False
    return True

def count_alpha_padding(image):
    rowCount = len(image)
    columnCount = len(image[0])

    topPadding = 0
    for rowIndex in range(rowCount):
        if (not is_row_transparant(image[rowIndex])):
            break
        topPadding += 1

    bottomPadding = 0
    for rowIndex in range(rowCount):
        if (not is_row_transparant(image[rowCount - 1 - rowIndex])):
            break
        bottomPadding += 1

    leftPadding = 0
    for columnIndex in range(columnCount):
        if (not is_column_transparant(image, columnIndex)):
            break
        leftPadding += 1

    rightPadding = 0
    for columnIndex in range(columnCount):
        if (not is_column_transparant(image, columnCount - 1 - columnIndex)):
            break
        rightPadding += 1

    return (topPadding, bottomPadding, leftPadding, rightPadding)

def create_image_subregion(image, topPadding, bottomPadding, leftPadding, rightPadding, padding=0):
    res = []
    srcRowCount = len(image)
    srcColCount = len(image[0])
    dstRowCount = srcRowCount - topPadding - bottomPadding + 2 * padding
    dstColCount = srcColCount - leftPadding - rightPadding + 2 * padding
    transparant_pixel = [0, 0, 0, 0]
    topAndBottomPadding = [[transparant_pixel] * dstColCount] * padding
    middlePadding = [transparant_pixel] * padding

    # First padding lines
    res += topAndBottomPadding

    # Middle line (padding + data frfom src + padding)
    for rowIndex in range(topPadding, srcRowCount - bottomPadding):
        srcRow = image[rowIndex]
        dstRow = middlePadding + srcRow[leftPadding:srcColCount-rightPadding].tolist() + middlePadding
        res += [dstRow]

    # Last padding lines
    res += topAndBottomPadding

    return res

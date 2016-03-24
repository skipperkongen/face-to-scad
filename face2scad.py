import json
import argparse
import sys
import pdb

def get_face_scad(response):
    # Skip bounding box
    for face_annotation in response['faceAnnotations']:
        verts = ",".join(
            ["[{0}, {1}]".format(v['x'], v['y'])
            for v in face_annotation['boundingPoly']['vertices']]
        )
        #yield 'color(0.9, 0.4, 0.4) polygon(points=[{0}]);'.format(verts)
        for landmark in face_annotation['landmarks']:
            label = landmark['type']
            pos = landmark['position']
            x, y, z = pos['x'], pos['y'], pos['z']
            yield 'translate([{0}, {1}, {2}]) color("Black") sphere(5);'.format(x, y, y)
            #yield 'translate([{0}, {1}, 0]) color("Red") text("{3}", size=1);'.format(x-10, y+5, y, label)

def main(args):
    try:
        data = json.load(open(args.input))
    except IOError:
        print "Not a valid JSON file:", args.input
        sys.exit(1)
    faces_scad = ["$fn = 30; "]
    for response in data['responses']:
        scad = "\n".join(get_face_scad(response))
        faces_scad.append(scad)
    print "\n".join(faces_scad)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Convert JSON to OpenSCAD.')
    parser.add_argument('input')
    args = parser.parse_args()
    main(args)

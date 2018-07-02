#!/usr/bin/env python

#find -type f -name "*.css" -exec cat {} \; | ./modMintYcolors.py >> 1-change-color.sh
#find -type f -name "*.svg" -exec cat {} \; | ./modMintYcolors.py >> 1-change-color.sh
#better results when modulation is based on Dark Green color 8fa876
import re
import colorsys
import sys

def modulateHSV (H, S, V):
	if (H > 0.22 and H < 0.28):
		H += .29
		S += .55
		#V -= .18
		if V < 0: V = 0 
		if S > 1: S = 1
		return (True, H, S, V)
	else:
		return (False, H, S, V)
		
def main():

	srcdir = "src" #+ " usr"
	matches = []

	for LINE in sys.stdin:
		ls = re.search("#[A-Fa-f0-9]{3,6}[;, ]", LINE)
		if ls:
			matches.append(ls.group(0)[1:-1])
		
		ls = re.search("rgba?.*?\)", LINE)
		if ls:
			matches.append(ls.group(0))
	matches = set(matches)
	for line in matches:
		#print line	
		m = re.match("([A-Fa-f0-9]{1,2})([A-Fa-f0-9]{1,2})([A-Fa-f0-9]{1,2})", line)
		if m:
			R = int(m.group(1),16)
			G = int(m.group(2),16)
			B = int(m.group(3),16)
			
			(H,S,V) = colorsys.rgb_to_hsv(R/255.,G/255.,B/255.)
			upd, H, S, V = modulateHSV(H, S, V)
			if upd:
				(R,G,B) = colorsys.hsv_to_rgb(H,S,V)
				R = int(255 * R)
				G = int(255 * G)
				B = int(255 * B)
				
				print "find %s -name \"*\" -type f -exec sed -i 's/%s/%02x%02x%02x/g' {} \;" % (srcdir, line, R,G,B, )

		m = re.match("rgba?\((\d+)\D*(\d+)\D*(\d+), *(.*)\)", line)
		if m:
			R = int(m.group(1),10)
			G = int(m.group(2),10)
			B = int(m.group(3),10)
			Astr = m.group(4)
			
			(H,S,V) = colorsys.rgb_to_hsv(R/255.,G/255.,B/255.)
			upd, H, S, V = modulateHSV(H, S, V)
			if upd:
				(R,G,B) = colorsys.hsv_to_rgb(H,S,V)
				R = int(255 * R)
				G = int(255 * G)
				B = int(255 * B)
				
				print "find %s -name \"*\" -type f -exec sed -i 's/%s/rgba(%d, %d, %d, %s)/g' {} \;" % (srcdir, line, R,G,B,Astr)

if __name__=="__main__":
	main()

Chord Profiles
==========================
A function (findChordName) that pretends to provide a SIMPLE framework where ALL the binary chord profiles are properly defined.

All the chords in 'chords.png' (extracted from [1]) are listed into the code.
Additionally, more chords (sus4, sus2, 7sus4, M7sus4, add2, madd2) were defined also in the library.

Working under Matlab and Octave.

Examples on how to use the function, see 'example.m'.

Comments:
---------------------------
Some chords can be misleading and the framework can provide "wrong" answers that actually are correct. For example:

chord = [C  C# D  D# E  F  F# G  G# A  A# B]

CM6   = [1  0  0  0  1  0  0  1  0  1  0  0] 

Am7   = [1  0  0  0  1  0  0  1  0  1  0  0] 

Note that the pitch profiles are exactly the same but depending on the context one pitch profile is more correct than other. Currently, the framework is still not capable to choose the best option.

Future work:
--------------------------
- Root coding: to give preference to a specific root.

Authors: 
--------------------------
Jordi Pons (idrojsnop@gmail.com) and Xavi Lizarraga (xavilizarraga@gmail.com)

References:
--------------------------
[1] - Jerry Coker. Improvising Jazz. Simon and Schuster, New York, 1964.

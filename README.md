Chord Profiles
==========================
A function (findChordName) that pretends to provide a SIMPLE framework where ALL the binary chord profiles are properly defined.

Two methods are provided: 'binary' and 'correlation'.

- Binary method: returns the name of the binary chord profile equal to the input (if there is). Therefore: this method only considers two possibilities (known or unknown): if the binary pitch-class distribution is not exactly equal to one chord profile, the chord is tagged as unknown.

- Correlation method: computes the cross-correlation between the input chord and all the chords into the library and chooses the chord with maximum correlation. In case that many chords have the same correlation, the simplest chord is chosen. Here is assumed that the simpler the most probable. A triad chord is considered simpler than a quatriad chord. 

Another important characteristic that makes different the correlation method compared to the binary method, is that the correlation method always return a candidate: the most possible candidate, even the input chord profile is not exactly equal to the ones in the dictionary; what makes the method interesting for noisy chord inputs. 
But if one wants confident estimations, the binary method is more suitable as if the algorithm is not sure would explicitly return: unknown chord.

All the chords in 'chords.png' (extracted from [1]) are listed into the code.
Additionally, more chords (sus4, sus2, 7sus4, M7sus4, add2, madd2) were also defined into the library.

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

License:
--------------------------
This code is Copyright 2015 Jordi Pons and Xavi Lizarraga. It is released under [Affero GPLv3 license](http://www.gnu.org/licenses/agpl.html) except for the third party libraries and images which have its own licenses.

This code is free software: you can redistribute it and/or modify it under the terms of the Affero GPLv3 as published by the Free Software Foundation. This code is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

%% EXAMPLES

% Each of the comented lines above correspond to a different chord.
% Uncomment it to understand how it works. Each of the elements of the 
%  vector corresponds to:
%
%       C     C#    D     D#    E     F     F#    G     G#    A     A#    B

%chord=[0     0     1     0     1     0     0     0     1     0     0     1]; % E7
%chord=[1     0     0     0     1     0     0     1     0     0     0     1]; % CM7
%chord=[0     0     0     0     1     0     0     0     1     0     0     1]; % EM
 chord=[0     0     1     0     1     0     1     1     0     0     0     1]; % Em7(9)

%return the chord name:
chord_name = findChordName(chord)
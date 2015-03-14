clc;clear all;close all;
%% EXAMPLES

% Each of the comented lines above correspond to a different chord.
% Uncomment them to understand how it works. Each of the elements of the 
% vector corresponds to:
%
%       C     C#    D     D#    E     F     F#    G     G#    A     A#    B

%chord=[0     0     1     0     1     0     0     0     1     0     0     1 ]; % E - NOT WORKING with correlation!
%chord=[1     0     0     0     1     0     0     1     0     0     0     1 ]; % CM7
%chord=[10    1     1     1     12    1     0     11    2     1     0     11]; % CM7 with noise!
%chord=[1     0     1     0     1     0     0     1     0     0     1     0 ]; % C9 
%chord=[0     0     0     0     1     0     0     0     1     0     0     1 ]; % EM
%chord=[0     0     1     0     1     0     1     1     0     0     0     1 ]; % Em7(9)
%chord=[0     0     1     0     0     0     1     0     0     1     0     0 ]; % DM

%get the chord name:
chord_name = findChordName(chord,'binary')

%chord_name = findChordName(chord,'correlation')
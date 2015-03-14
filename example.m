clc;clear all;close all;

%% EXAMPLES
% Each of the comented lines above correspond to a different chord.
% Uncomment them to understand how it works. 

% --------------------------
% CASE 1: as the chords are already binary chord profiles, work under the
% both methods ('binary' and 'correlation).
% --------------------------
% Each of the elements of the vector corresponds to:
%       C     C#    D     D#    E     F     F#    G     G#    A     A#    B
%chord=[1     0     0     0     1     0     0     1     0     0     0     1 ]; % CM7
%chord=[1     0     1     0     1     0     0     1     0     0     1     0 ]; % C9 
%chord=[0     0     0     0     1     0     0     0     1     0     0     1 ]; % EM
 chord=[0     0     1     0     1     0     1     1     0     0     0     1 ]; % Em7(9)
%chord=[0     0     1     0     0     0     1     0     0     1     0     0 ]; % DM
%chord=[0     0     1     0     1     0     0     0     1     0     0     1 ]; % E7
%chord=[1     0     0     0     1     0     0     1     0     0     1     0 ]; % C7

% Get the chord name:
chord_name_corr = findChordName(chord,'correlation')
chord_name_binary = findChordName(chord,'binary')

% --------------------------
% CASE 2: If the chord to estimate has noise, the suitable method is the
% 'correlation'.
% --------------------------
% Each of the elements of the vector corresponds to:
%       C     C#    D     D#    E     F     F#    G     G#    A     A#    B
chord=[ 10    1     1     1     12    1     0     11    2     1     0     11]; % CM7 with noise!

% Get the chord name:
chord_name_corr = findChordName(chord,'correlation')

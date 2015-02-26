function chord_name = findChordName(chord)
    % given a pitch profile such as:
    % chord=[0     0     1     0     1     0     0     0     1     0     0     1];
    % return the chord name:
    % chord_name = findChordName(chord); chord_name = E7
    %
    % Authors: Jordi Pons (idrojsnop@gmail.com) and Xavi Lizarraga (xavilizarraga@gmail.com)
    
    [cell_pitch_class, cell_chords_profiles_names, chords_profiles] = loadPitchClasses();
    
    count=0;
    flag=0;
    chord_profile=[];
    while flag==0
        [flag_chord_profile, chord_profile]=ismember(chord,circshift(chords_profiles',count)','rows');
        count=count+1;
        if count>size(chords_profiles,2) || flag_chord_profile==1
            flag=1;
        end
    end
    if flag_chord_profile==0
        chord_name='Unknown :)';
    else
        chord_name=strcat(cell_pitch_class{count},cell_chords_profiles_names{chord_profile});
    end
end

function [cell_pitch_class, cell_chords_profiles_names, chords_profiles] = loadPitchClasses()
    % Authors: Jordi Pons and Xavi Lizarraga

    pitch_class=['C ';'C#';'D ';'D#';'E ';'F ';'F#';'G ';'G#';'A ';'A#';'B ';];
    cell_pitch_class=cellstr(pitch_class);

    % [!!] Each of the rows of pitch_class need to have the same char length
    % (in that case 2), otherwise cellstr() would give error.
    % If a row is not enough long, fill it with spaces; like: 'C '.
    % The resulting cell_pitch_class have the proper length.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                C  C# D  D# E  F  F# G  G# A  A# B
    chords_profiles=[1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0;
                     1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0;
                     1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0;
                     1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0;

                     1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1;
                     1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1;
                     1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1;
                     1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1;
                     1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1;

                     1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0;
                     1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0;
                     1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0;
                     1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0;

                     1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0;
                     1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0;
                     1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0;
                     1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1;
                     1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1;
                     1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1;
                     1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1;
                     
                     1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0; 
                     1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0;
                     1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0;
                     1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0;
                     1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0;

                     1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1;
                     1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0;
                     1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0;
                     1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0;
                     1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0;

                     
                     1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0;
                     1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0;
                     1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0;
                     1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0;

                     1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0;
                     1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0;
                     1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0;
                     1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0;

                     1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0;
                     1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0;
                     1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0];
    %                C  C# D  D# E  F  F# G  G# A  A# B 

    % [!!] Those are binary chord profiles that follow the structure defined in
    % pitch_class. 
    % For example:  CM is [1  0 0  0 1 0  0 1  0 0  0 0]
    %               where [C C# D D# E F F# G G# A A# B]
    %          what means  C         E      G          -> CM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % The chord names and the chord profiles has been defined following the next reference:
    % Harte, C. (2010). Towards automatic extraction of harmony information from music signals 
    % (page.42, Doctoral dissertation, Department of Electronic Engineering, Queen Mary, University of London).
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % With the last changes each string should contains 12 characters. 
    chords_profiles_names=[
        'M               ';'M6              ';'M6(9)           ';'M6(9,#11)       ';...
        'M7              ';'M9              ';'M9(#11)         ';'M13             ';...
        'M13(#11)        ';'m               ';'m6              ';'m6(9)           ';...
        'm6(9,11)        ';'m7              ';'m7(9)           ';'m7(9,11)        ';...
        'm(maj7)         ';'m(maj7,9)       ';'m(maj7,9,11)    ';'m(maj7,9,#11,13)';...
        'dim             ';'dim7            ';'dim9            ';'dim11           ';...
        'dim11(b13)      ';'dim(maj7)       ';'dim(min7)       ';'7(b5)           ';...
        '7(b5,9)         ';'7(b5,9,11)      ';'aug             ';'aug7            ';...
        'aug7(9)         ';'aug7(b9)        ';'7               ';'9               ';...
        '7(b9)           ';'7(#9)           ';'9(11)           ';'9(#11)          ';...
        '13(#11)         '];
    
    cell_chords_profiles_names=cellstr(chords_profiles_names);

    % [!!] Each of the rows of chords_profiles_names need to have the same char length
    % (in that case 6), otherwise cellstr() would give error.
    % If a row is not enough long, fill it with spaces; like: 'M     '.
    % The resulting cell_chords_profiles_names have the proper length.
    
end
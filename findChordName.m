function chord_name = findChordName(chord,method)
    % Return the chord name for a given binary chord profile.
    % INPUT:
    %	- chord: vector containing the BINARY chord profile of length 12, each bin corresponding to [C  C# D  D# E  F  F# G  G# A  A# B].
    %   - method: binary or correlation.
    % OUTPUT:
    %   - chord_name: an string providing the chord name of the given chord profile.
    % EXAMPLE:
    %   given a pitch profile such as:
    %    	chord=[0     0     1     0     1     0     0     0     1     0     0     1];
    %   return the chord name:
    % 		chord_name = findChordName(chord); 
    %		chord_name = E7
    %
    % Authors: Jordi Pons (idrojsnop@gmail.com) and Xavi Lizarraga (xavilizarraga@gmail.com)
    
    % load the dictionary of chord profiles defined in the function loadChordClasses() below
    [cell_pitch_class, cell_chords_profiles_names, chords_profiles] = loadChordClasses();
    
    switch lower(method)
        %%%% BINARY %%%%
        case {'binary'}  
            
            count=0;
            flag=0;
            chord_profile=[];
            while flag==0	% find the binary pitch profile in the dictionary that is EQUAL to the input binary chord profile.
                [flag_chord_profile, chord_profile]=ismember(chord,circshift(chords_profiles',count)','rows');
                count=count+1;
                if count>size(chords_profiles,2) || flag_chord_profile==1
                    flag=1;
                end
            end
            % Doing the shifting the algorithm is transposing the chords defined in C. So: the count variable takescare of the number of tones transposed from C.

            % Fetch the name of the chord with the previously found indormation: count (# semitones transposed from C: the root. ex: C, D or B.) and chord_profile (position of the chord over the root. ex: m7, M or M6).
            if flag_chord_profile==0
                chord_name='Unknown :)';
            else
                chord_name=strcat(cell_pitch_class{count},cell_chords_profiles_names{chord_profile});
            end

        %%%% CORRELATION %%%%
        case {'correlation'}
            
            % what does that mean negative correlation in that context?
            
            % inverse weight for length of note if not ordered.
            
            % CONSTRAINT: one can only input binary chord profiles! Should
            % binarize outside my function.
            
            % compute correlation for all cases
            corr_coeff=zeros(size(cell_pitch_class,1),size(chords_profiles,1));
            for i=0:(size(cell_pitch_class,1)-1)
                for j=1:size(chords_profiles,1)
                    xcorr_vect=xcorr(chord,circshift(chords_profiles(j,:),[i i]));
                    corr_coeff(i+1,j)=xcorr_vect(length(chord));
                end
            end
            
            % find the most correlated: candidates
            [i_max,j_max] = find(corr_coeff == max(round(corr_coeff(:))));
                % saving the most correlated
                S_i_max=i_max; 
                S_j_max=j_max;
            
            % find the ones with the same number of notes as chord
            ii=0;
            sum_chord=sum(chord);
            while ii<numel(i_max)
                ii=ii+1;
                % if is not the same length, remove.
                if sum(circshift(chords_profiles(j_max(ii),:),[i_max(ii) i_max(ii)])) ~= sum_chord
                   i_max(ii)=[];
                   j_max(ii)=[];
                   ii=ii-1;
                end
            end
            
            % if all the candidates were of different length compared to 'chord'
            % means that the input 'chord' is not defined in the dictionary below.
            
            % so, just take one with maximum correlation.

            % notice that the first candidate is choosen, that's because in
            % the dictionary are ordenated from simpler (much probable) to
            % more complex (les probable).
            if isempty(j_max)
               disp('Taking the most similar: no dictionary entries equal to the input chord!');
               i_max(1)=S_i_max(1);
               j_max(1)=S_j_max(1);
            end
            
            % find chord name
            chord_name=strcat(cell_pitch_class{i_max(1)},cell_chords_profiles_names{j_max(1)});
            
        %%%% OTHERWISE %%%%
        otherwise
            
            disp('Unknown method.')
            
    end
end

function [cell_pitch_class, cell_chords_profiles_names, chords_profiles] = loadChordClasses()
    pitch_class=['C ';'C#';'D ';'D#';'E ';'F ';'F#';'G ';'G#';'A ';'A#';'B ';];
    cell_pitch_class=cellstr(pitch_class);

    % [!!] Each of the rows of pitch_class need to have the same char length
    % (in that case 2), otherwise cellstr() would give error.
    % If a row is not enough long, fill it with spaces; like: 'C '.
    % The resulting cell_pitch_class have the proper length.

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %                C  C# D  D# E  F  F# G  G# A  A# B
    chords_profiles=[1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0;    % M;                (3) 1
                     1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0;    % m                 (3) 2
                     1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0;    % dim               (3) 3
                     1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0;    % aug               (3) 4
                     
                     1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0;    % sus4              (3) 5
                     1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0;    % sus2              (3) 6                                          
                     1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0;    % 7                 (4) 7
                     1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0;    % m7                (4) 8
                     
                     1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1;    % M7                (4) 9
                     1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1;    % m(maj7)           (4) 10                
                     1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0;    % M6;               (4) 11
                     1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0;    % m6                (4) 12
                     
                     1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0;    % aug7              (4) 13
                     1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0;    % dim7              (4) 14
                     1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1;    % dim(maj7)         (4) 15
                     1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0;    % dim(min7)         (4) 16
                     
                     1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0;    % 7(b5)             (4) 17
                     1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0;    % 7sus4             (4) 18
                     1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1;    % M7sus4            (4) 19
                     1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0;    % 7sus2             (4) 20
                     
                     1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1;    % M7sus2            (4) 21
                     1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0;    % add2              (4) 22
                     1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0;    % madd2             (4) 23
                     1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0;    % 9                 (5) 24
                     
                     1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0;    % m7(9)             (5) 25
                     1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0;    % 7(b9)             (5) 26
                     1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0;    % 7(#9)             (5) 27
                     1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1;    % M9                (5) 28
                     
                     1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1;    % m(maj7,9)         (5) 29
                     1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0;    % M6(9);            (5) 30
                     1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0;    % m6(9)             (5) 31
                     1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0;    % dim9              (5) 32 
                     
                     1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0;    % 7(b5,9)           (5) 33
                     1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0;    % aug7(9)           (5) 34
                     1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0;    % aug7(b9)          (5) 35
                     1, 0, 1, 0, 1, 1, 1, 0, 0, 0, 1, 0;    % 7(b5,9,11)        (6) 36
                     
                     1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0;    % 9(11) or 9sus     (6) 37
                     1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0;    % 9(#11)            (6) 38
                     1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0;    % m7(9,11)          (6) 39
                     1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1;    % m(maj7,9,11)      (6) 40
                     
                     1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0;    % dim11             (6) 41
                     1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0;    % M6(9,#11)         (6) 42
                     1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1;    % M9(#11)           (6) 43
                     1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1;    % M13               (6) 44 
                     
                     1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0;    % m6(9,11)          (6) 45                    
                     1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0;    % 13(#11)           (7) 46
                     1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1;    % M13(#11)          (7) 47
                     1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1;    % m(maj7,9,#11,13)  (7) 48
                     
                     1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0];   % dim11(13)         (7) 49
    %                C  C# D  D# E  F  F# G  G# A  A# B 

    % [!!] Those are binary chord profiles that follow the structure defined in
    % pitch_class. 
    % For example:  CM is [1  0 0  0 1 0  0 1  0 0  0 0]
    %               where [C C# D D# E F F# G G# A A# B]
    %          what means  C         E      G          -> CM

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % The chord names and the chord profiles has been defined following the next references:
    %
    % [1] Harte, C. (2010). Towards automatic extraction of harmony information from music signals 
    % (page.42, Doctoral dissertation, Department of Electronic Engineering, Queen Mary, University of London).
    %
    % [2] http://en.wikipedia.org/wiki/Suspended_chord
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % With the last changes each string should contains 16 characters. 
    chords_profiles_names=[
        'M               ';'m               ';'dim             ';'aug             ';...
        'sus4            ';'sus2            ';'7               ';'m7              ';...
        'M7              ';'m(maj7)         ';'M6              ';'m6              ';...
        'aug7            ';'dim7            ';'dim(maj7)       ';'dim(min7)       ';...
        '7(b5)           ';'7sus4           ';'M7sus4          ';'7sus2           ';...
        'M7sus2          ';'add2            ';'madd2           ';'9               ';...
        'm7(9)           ';'7(b9)           ';'7(#9)           ';'M9              ';...
        'm(maj7,9)       ';'M6(9)           ';'m6(9)           ';'dim9            ';...
        '7(b5,9)         ';'aug7(9)         ';'aug7(b9)        ';'7(b5,9,11)      ';...
        '9(11)           ';'9(#11)          ';'m7(9,11)        ';'m(maj7,9,11)    ';...
        'dim11           ';'M6(9,#11)       ';'M9(#11)         ';'M13             ';...
        'm6(9,11)        ';'13(#11)         ';'M13(#11)        ';'m(maj7,9,#11,13)';...
        'dim11(b13)      '];
    
    cell_chords_profiles_names=cellstr(chords_profiles_names);

    % [!!] Each of the rows of chords_profiles_names need to have the same char length
    % (in that case 16), otherwise cellstr() would give error.
    % If a row is not enough long, fill it with spaces; like: 'M6              '.
    % The resulting cell_chords_profiles_names have the proper length.
    
end

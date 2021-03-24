%% How to Use
%    
% Run the synth function to start gui.  

% Premade structs to use as arguments are in premadeSounds.mat(ex.
% synth(guitarPluck)
%    
% The gui contains three panels with inputs to change:
%    - Frequency - plots the frequencies in the sound over time. Inputs are
%    seperated by comma written as a note(ex. C4, E4, G5), a number(ex.
%    440 for A4), or a function of t (ex.  func(440+10*t) for a chirp
%    signal) 
%
%    - Harmonic - shows the amplitudes of the harmonics added to the note
%    (default of 1 means no harmonics will be added).  Input can be an
%    array of values or a function of x(ex.  func(exp(-x))
%    
%    - Envelope - shows the envelope of the sound.  Inputs are the same as
%    the harmonic panel
%
%
%% TODO
% 
% Functionality
%     - Plots signal(a couple periods, entire wave, fft, or dtft)
%     - Switch between sounds and add ability to add new sounds and
%     copy sounds
%     - Addable slider for changing values quickly
%     - Change phase of harmonics
%     - Add effects
%        * Filter
%        * Echo
%        * Clipping
%
% User friendliness
%     - Premade sounds
%     - Keyboard input
%
% Background
%     
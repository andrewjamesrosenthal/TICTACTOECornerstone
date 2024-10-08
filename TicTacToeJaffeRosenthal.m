% Andrew and Sean 9/29/24
%Tic Tac Toe
% Pseudocode for Tic-Tac-Toe Game
%Display ASCII art and welcome message
%Display Rules of game
%Enter player 1 & 2 names
%Flip "coin" to see who goes first, if heads player 1 starts tails player 2
%starts
%Uses while loop that to start the game 
    %Check if anyone won
        %Breaks loop if true
    %Calls board plot
    %Lets users enter location
        %If it is a quite command then quite
        %Assert that is fromat of {A,B,C}{1,2,3}
            %If not reprompt
        %Convert to cell number
        %If taken
            %repromt
        %Else place piece and switch player

clc; clear;
disp("The Program was written by Andrew and Sean")

% welcome message
disp('Welcome to')


disp('████████╗██╗ ██████╗    ████████╗ █████╗  ██████╗     ████████╗ ██████╗  ███████╗')
disp('╚══██╔══╝██║██╔════╝       ██╔══╝██╔══██╗██╔════╝     ╚══██╔══╝██╔═══██╗ ██╔════╝')
disp('   ██║   ██║██║            ██║   ███████║██║             ██║   ██║   ██║ █████╗  ')
disp('   ██║   ██║██╚════╗       ██║   ██╔══██║██║             ██║   ██║   ██║ ██╔══╝  ')
disp('   ██║   ██║╚██████║       ██║   ██║  ██║║██████╗        ██║   ╚██████╔╝ ███████╗')
disp('   ╚═╝   ╚═╝ ╚═════╝       ╚═╝   ╚═╝  ╚═╝╚══════╝        ╚═╝    ╚═════╝  ╚══════╝')




% Displaying the rules of Tic-Tac-Toe
disp(' ')
disp('Here are the rules of the game:')
disp('1. The game is played on a 3x3 grid (9 cells in total).')
disp('2. Players take turns to place their symbol (X or O) in an empty cell.')
disp('3. Player 1 uses ''X'' and Player 2 uses ''O''.')
disp('4. The goal is to align three of your symbols (X or O) either:')
disp('   a) Horizontally,')
disp('   b) Vertically, or')
disp('   c) Diagonally.')
disp('5. A player cannot place their symbol in a cell that is already occupied.')
disp('6. The game ends when a player aligns three symbols or when all cells')
disp('   are filled and no player has won (resulting in a draw).')
disp(' ')
disp('7. To place your marker enter the row and column where you want to play (A1, B1, C3, etc.)')
disp('Let''s play!')

names = ["" ""];
names(1) = input('What is player 1 name: ', 's');  % Correct use of 's' for string input
names(2) = input('What is player 2 name: ', 's');  % Make sure both have 's'

% flip coin
input('Press enter to flip a coin to determine who goes first: ', 's');
clc;
pause(0.5)

coinFrames = ['-', '\', '|', '/'];
pauseTime = 0.2;

for i = [1:9]
    disp(coinFrames(mod(i-1, 4)+1));
    pause(pauseTime);
    clc;
end

turn = randi([1,2],1);  
fprintf('Coin was heads! %s goes first!\n', names(turn));
pause(1)
clc;

boardArr = repelem(0, 9);
% Load background music and start playing it in a loop
[gMusic, gMusicFs] = audioread('gamemusic.mp3');
[moveSound, moveFs] = audioread('move.mp3');
[quitSound, quitFs] = audioread('quit.wav');

playAgain = 'y';

%Allows user to play again after finisihing a game
while lower(playAgain) == 'y' 

    % Main game loop initialization
    boardArr = repelem(0, 9);
    turn = randi([1, 2], 1);  % Randomly decide who goes first
    fprintf('Coin was heads! %s goes first!\n', names(turn));
    pause(1);
    clc;

    % Load and start background music (if applicable)
    bgMusicPlayer = audioplayer(gMusic, gMusicFs);
    play(bgMusicPlayer);

% Main game loop
while (true)
    [w, s, f] = Checkwin_JR(boardArr);
    Boardplot_JR(boardArr, w, s, f);

    if w == 1 || w == 2
        % Play the win sound when a winner is detected
        [y, Fs] = audioread('wins.wav');
        sound(y, Fs);
        disp(names(w) + ' wins the game!');
        stop(bgMusicPlayer);
        break;  % Break out of the main game loop when a player wins
    elseif w == -1
        % Handle the tie condition
        disp("It is a tie!");
        stop(bgMusicPlayer);
        break;  % Break out of the main game loop when the game ends in a tie
    end

    disp("It is " + names(turn) + "'s turn.");

    % Get and validate row input
    while true
        rowInput = input("Enter the row (A, B, C) or 'q' to quit: ", 's');
        if lower(rowInput) == "q"
            disp("User has quit the game");
            stop(bgMusicPlayer);
            sound(quitSound, quitFs);
            break;  % Exit game loop on quit
        elseif ismember(lower(rowInput), {'a', 'b', 'c'})
            break;
        else
            disp("Invalid row input, please enter A, B, or C.");
        end
    end

    if lower(rowInput) == "q"
        break;
    end

    % Get and validate column input
    while true
        colInput = input("Enter the column (1, 2, 3) or 'q' to quit: ", 's');
        if lower(colInput) == "q"
            disp("User has quit the game");
            stop(bgMusicPlayer);
            sound(quitSound, quitFs);
            break;
        end

        colNumber = str2double(colInput);

        if isnan(colNumber) || ~ismember(colNumber, [1, 2, 3])
            disp("Invalid column input, please enter 1, 2, or 3.");
        else
            break;
        end
    end

    if lower(colInput) == "q"
        break;
    end

    % Convert row and column to cell index
    cell = (upper(rowInput) - 'A') * 3 + str2double(colInput);

    if ~checktaken_JR(boardArr, cell)
        sound(moveSound, moveFs);  % Play move sound
        boardArr(cell) = turn;  % Place piece
        turn = mod(turn, 2) + 1;  % Switch player
        clc;
    else
        disp("Invalid move, spot already taken. Try again.");
    end
end

% After game ends (either via win, tie, or quit)
disp("Game over! Thanks for playing.");

% Ask if the players want to play another round
playAgain = input("Do you want to play another round? (y/n): ", 's');
if lower(playAgain) ~= 'y'
    disp("Thank you for playing! Goodbye.");
    stop(bgMusicPlayer);  % Stop background music at the end of the session
    return;  % Exit the script or function
end
end

% Clear the command window and reset game state
clc;
% Reset the board and other game variables here if necessary

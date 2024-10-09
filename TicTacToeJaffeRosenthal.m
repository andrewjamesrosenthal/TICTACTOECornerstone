% Andrew and Sean 9/29/24
%Tic Tac Toe
% Pseudocode for Tic-Tac-Toe Game
% This script runs a command-line Tic-Tac-Toe game.
% Clears console, displays a welcome message, and the game rules.
% Prompts users to input their names (Player 1 and Player 2).
% Loads game sound effects (background music, move sound, quit sound).
% Allows players to play multiple rounds through a loop.
% Coin flip determines which player goes first.
% Resets the game board and starts background music.
% Main game loop:
% Checks for a win or tie after each turn.
% Displays the game board.
% Prompts the current player to enter their move (row and column).
% Validates input and places the symbol on the board.
% Allows players to quit anytime by entering 'q'.
% If a player wins or ties, announces the result and stops the music.
% After each round, prompts players if they want to play again.
% Ends the game if players choose not to continue.


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
names(1) = input('What is player 1 name: ', 's');
names(2) = input('What is player 2 name: ', 's');

% Loads the game sounds
[gMusic, gMusicFs] = audioread('gamemusic.mp3');
[moveSound, moveFs] = audioread('move.mp3');
[quitSound, quitFs] = audioread('quit.wav');

playAgain = 'y';

% Allows user to play again after finishing a game
while lower(playAgain) == 'y' 
    % Flip coin
    input('Press enter to flip a coin to determine who goes first: ', 's');
    clc;
    pause(0.5)
    
    % Coin flip animation
    coinFrames = ['-', '\', '|', '/'];
    pauseTime = 0.2;
    for i = 1:9
        disp(coinFrames(mod(i-1, 4)+1));
        pause(pauseTime);
        clc;
    end
    
    boardArr = repelem(0, 9);
    turn = randi([1, 2], 1);  % Randomly decide who goes first
    fprintf('Coin was heads! %s goes first!\n', names(turn));
    pause(1);
    clc;

    % Load and start background music
    bgMusicPlayer = audioplayer(gMusic, gMusicFs);
    play(bgMusicPlayer);

    % Main game loop
    while true
        [w, s, f] = Checkwin_JR(boardArr);
        Boardplot_JR(boardArr, w, s, f);
        % Checks if the game is over in a win or a tie and plays win sound if so
        if w == 1 || w == 2
            [y, Fs] = audioread('wins.wav');
            sound(y, Fs);
            disp(names(w) + ' wins the game!');
            stop(bgMusicPlayer);
            break;  
        elseif w == -1
            disp("It is a tie!");
            stop(bgMusicPlayer);
            break;
        end

        disp("It is " + names(turn) + "'s turn.");

        % Quits game and plays quit sound if user enters q
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

        % Moves
        if ~checktaken_JR(boardArr, cell)
            sound(moveSound, moveFs);
            boardArr(cell) = turn; 
            turn = mod(turn, 2) + 1;
            clc;
        else
            disp("Invalid move, spot already taken. Try again.");
        end
    end

    disp("Game over! Thanks for playing.");

    % Ask if the players want to play another round
    playAgain = input("Do you want to play another round? (y/n): ", 's');
    % Ends game and stops music if not y
    if lower(playAgain) ~= 'y'
        disp("Thank you for playing! Goodbye.");
        stop(bgMusicPlayer); 
        return;  
    end
    clc;
end

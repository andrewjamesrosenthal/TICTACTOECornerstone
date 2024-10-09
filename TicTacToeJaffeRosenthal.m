% Andrew and Sean 9/29/24
% Tic Tac Toe
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

% Loads the game sounds
[samp, freq] = audioread('gamemusic.mp3');
bgMusic = audioplayer(samp, freq);

[moveSound, moveFs] = audioread('move.mp3');
[winSound, winFs] = audioread('wins.wav');
[quitSound, quitFs] = audioread('quit.wav');
[sadSound, sadFs] = audioread('sad.mp3');
[yaySound, yayFs] = audioread('yay.mp3');
[invalidSound, invalidFs] = audioread('invalid.mp3');

% welcome message
disp("The Program was written by Andrew and Sean")

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
disp('7. To place your marker enter the row and column where you want to play (A1, B1, C3, etc.)')
disp(' ')
disp('Let''s play!')

names = ["" ""];
names(1) = input('What is player 1 name: ', 's');
names(2) = input('What is player 2 name: ', 's');



playAgain = 'y';

% Allows user to play again after finishing a game
while lower(playAgain) == 'y' 
    boardArr = repelem(0, 9);
    
    % flipcoin animation
    flipcoin_JR();

    turn = randi([1, 2], 1);  % Randomly decide who goes first
    sound(yaySound, yayFs);
    if turn == 1
        fprintf('Coin was heads! %s goes first!\n', names(turn));
    else
        fprintf('Coin was tails! %s goes first!\n', names(turn));
    end  % Added 'end' here to close the if-else block

    pause(1.5);
    clc;


    % Load and start background music
    play(bgMusic);

    % Main game loop
    while true
        [w, s, f] = Checkwin_JR(boardArr);
        Boardplot_JR(boardArr, w, s, f);
        % Checks if the game is over in a win or a tie and plays win sound if so
        if w == 1 || w == 2
            sound(winSound, winFs);
            disp(names(w) + ' wins the game!');
            stop(bgMusic);
            break;  
        elseif w == -1
            disp("It is a tie!");
            stop(bgMusic);  % Removed the incorrect 'bgMusicPlayer' variable
            break;
        end

        
        disp("It is " + names(turn) + "'s turn.");

        % Quits game and plays quit sound if user enters q
        while true
            inp = input("Enter the row and col (ex. A1) or 'q' to quit: ", 's');
            if strlength(inp) == 2
                % breaks apart the input
                rowInp = lower(inp(1));
                colInp = str2double(inp(2));

                % checks if row is wrong
                if ~ismember(rowInp, {'a', 'b', 'c'})
                    sound(invalidSound, invalidFs);
                    disp("Invalid row input, please enter A, B, or C.");
                % checks if col is wrong
                elseif isnan(colInp) || ~ismember(colInp, [1, 2, 3])
                    sound(invalidSound, invalidFs);
                    disp("Invalid column input, please enter 1, 2, or 3.");
                % row and col are at least on board
                else
                    % Convert row and column to cell index
                    cell = (rowInp - 'a') * 3 + colInp;
            
                    % check if cell already taken
                    if checktaken_JR(boardArr, cell)
                        sound(invalidSound, invalidFs);
                        disp("Invalid move, spot already taken. Try again.");
                    % move is valid
                    else
                        % complete move
                        sound(moveSound, moveFs);
                        boardArr(cell) = turn; 
                        turn = mod(turn, 2) + 1;
                        clc;
                        break;
                    end
                end
            % if quit flag
            elseif lower(inp) == "q"
                disp("User has quit the game");
                stop(bgMusic);
                sound(quitSound, quitFs);
                break;  % Exit game loop on quit
            % input is just completely wrong
            else
                sound(invalidSound, invalidFs);
                disp("Invalid input length. Please enter 2 character, a row and col pair.");
            end
        end

        % checks if result quit again (exits out of game loop this time)
        if lower(inp) == "q"
            break;
        end
    end
    
    stop(bgMusic);
    disp("Game over! Thanks for playing.");

    % Ask if the players want to play another round
    playAgain = input("Do you want to play another round? (y/n): ", 's');

    % loop to ensure readable answer
    while true
        % Ends game and stops music if not y
        if lower(playAgain) == 'y'
            sound(yaySound, yayFs);
            clc;
            break
        elseif lower(playAgain) == 'n'
            sound(sadSound, sadFs);
            disp("Awww, goodbye then :(");
            pause(1);
            disp("Play again when you can!")
            return;  
        else
            fprintf("I don't know what '%s' means, but you meant yes right? (y/n): ", playAgain);
            playAgain = input("", "s");
        end
    end
end

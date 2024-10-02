%Tic Tac Toe
% Tic Tac Toe
clc; clear;
disp("The Program was written by Andrew and Sean")
% Displaying the rules of Tic-Tac-Toe
disp('Welcome to')


disp('████████╗██╗ ██████╗    ████████╗ █████╗  ██████╗     ████████╗ ██████╗  ███████╗')
disp('╚══██╔══╝██║██╔════╝       ██╔══╝██╔══██╗██╔════╝     ╚══██╔══╝██╔═══██╗ ██╔════╝')
disp('   ██║   ██║██║            ██║   ███████║██║             ██║   ██║   ██║ █████╗  ')
disp('   ██║   ██║██╚════╗       ██║   ██╔══██║██║             ██║   ██║   ██║ ██╔══╝  ')
disp('   ██║   ██║╚██████║       ██║   ██║  ██║║██████╗        ██║   ╚██████╔╝ ███████╗')
disp('   ╚═╝   ╚═╝ ╚═════╝       ╚═╝   ╚═╝  ╚═╝╚══════╝        ╚═╝    ╚═════╝  ╚══════╝')





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
disp('7. To place your marker enter the row and column where you want to play')
disp('Let''s play!')


name1 = input('What is player 1 name: ', 's');  % Correct use of 's' for string input
name2 = input('What is player 2 name: ', 's');  % Make sure both have 's'

while (true)
    coingo = input('Press 1 to flip a coin to determine who goes first: ', 's');
    if (coingo == '1')
        clc;
        pause(0.5)
        disp('-')
        pause(0.2)  % 0.2 seconds pause (200 milliseconds)
        clc;
        
        disp('\')
        pause(0.2)
        clc;
        
        disp('|')
        pause(0.2)
        clc;
        
        disp('/')
        pause(0.2)
        clc;
        
        disp('-')
        pause(0.2)
        clc;

        break
    else
        disp('Incorrect input, please press 1 to flip a coin.');
    end
end

coin = randi([1,2],1);  
if coin == 1
    fprintf('Coin was heads! %s goes first!\n', name1);
else
    fprintf('Coin was tails! %s goes first!\n', name2);
end

while (true)
    playon = input('Please press s to continue: ', 's');  
    if (playon == 's')
        figure; 
        plot(nan, nan);
        axis([0 10 0 10]);
        title('TIC TAC TOE');
        break
    end
end


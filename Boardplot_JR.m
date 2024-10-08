% Andrew and Sean 10/1/24

% pseudo code:
% function inputs: arr & winner (x or o) & start + finish of 3 in a row
% 
% Define style variables
% weight, gridColor, xColor, oColor, winTextColor, POC
% 
% Board dimensions variables
% lef, top, spacing
% 
% Configure viewport
% axis to square with defined limits
% 
% Draw horizontal and vertical lines for the grid
% 
% Label rows and columns with ABC and 123
% 
% Draw 'X' and 'O' based on arr values
% FOR each cell in arr DO
%     CALCULATE cell center (X, Y)
%     IF arr[i] == 1 THEN
%         DRAW 'X' at (X, Y)
%     ELSE IF arr[i] == 2 THEN
%         DRAW 'O' at (X, Y)
% 
% Check for winner
% IF winner != 0 THEN
%     Change the statement and connector color based on winner
%     Draw winning line and display message



function [] = Boardplot_JR (arr, winner, start, finish)
    clf;
    hold on

    % Turn off ticks
    set(gca, 'XTick',[],'YTick',[]);

    % Board style variables
    weight = 7.5;
    gridColor = 'k';
    xColor = 'r';
    oColor = 'b';
    winTextColor = 'g';  % Color of connecting line after winning
    POC = 0.7;  % Percent of cell filled by markers

    % Board dimensions variables
    lef = -1.5;
    top = 1.5;
    spacing = 1;

    % Setting the viewport
    axis square
    axis([lef - 0.33 * spacing, lef + 3.33 * spacing, top - 3.33 * spacing, top + 0.33 * spacing])

    % Drawing the grid
    line([lef, lef + 3 * spacing], [top - spacing, top - spacing], 'Color', gridColor, 'LineWidth', weight)
    line([lef, lef + 3 * spacing], [top - 2 * spacing, top - 2 * spacing], 'Color', gridColor, 'LineWidth', weight)
    line([lef + spacing, lef + spacing], [top, top - 3 * spacing], 'Color', gridColor, 'LineWidth', weight)
    line([lef + 2 * spacing, lef + 2 * spacing], [top, top - 3 * spacing], 'Color', gridColor, 'LineWidth', weight)

    % Printing column indicators
    rowValues = ['A', 'B', 'C'];
    for i = 1 : 3
        % Column labels
        text(lef + spacing * (i - 0.5), top + spacing / 5, string(i), 'Color', gridColor, 'FontSize', 20);
        % Row labels
        text(lef - spacing / 4, top - spacing * (i - 0.5), rowValues(i), 'Color', gridColor, 'FontSize', 20);
    end

    % Loop through all cells of the mark array
    for i = 1:size(arr, 2)
        % Getting center coordinates of the current cell
        X = lef + spacing * (0.5 + mod(i - 1, 3));
        Y = top - spacing * (0.5 + floor((i - 1) / 3));
        % Check if it's an 'X'
        if arr(i) == 1
            % Draws 'X'
            line([X - spacing * POC / 2, X + spacing * POC / 2], [Y - spacing * POC / 2, Y + spacing * POC / 2], 'Color', xColor, 'LineWidth', weight);
            line([X - spacing * POC / 2, X + spacing * POC / 2], [Y + spacing * POC / 2, Y - spacing * POC / 2], 'Color', xColor, 'LineWidth', weight);
        % Check if it's an 'O'
        elseif arr(i) == 2
            % Draws 'O'
            rectangle('Position', [X - spacing * POC / 2, Y - spacing * POC / 2, spacing * POC, spacing * POC], 'Curvature', [1, 1], 'EdgeColor', oColor, 'LineWidth', weight);
        end
    end

    % Win screen
    if winner ~= 0
        % Customize output based on who won
        if winner == 1
            statement = 'X Wins!';
            conColor = xColor;
        else
            statement = 'O Wins!';
            conColor = oColor;
        end

        % Convert start and finish cells to row and column indices
        srow = floor((start - 1) / 3);
        scol = mod(start - 1, 3);
        frow = floor((finish - 1) / 3);
        fcol = mod(finish - 1, 3);

        % Get the center coordinates of start and finish cells
        X_start = lef + spacing * (0.5 + scol);
        Y_start = top - spacing * (0.5 + srow);
        X_finish = lef + spacing * (0.5 + fcol);
        Y_finish = top - spacing * (0.5 + frow);

        extendX = 0.25 * (X_finish - X_start);
        extendY = 0.25 * (Y_finish - Y_start);
        X_start = X_start - extendX;
        Y_start = Y_start - extendY;
        X_finish = X_finish + extendX;
        Y_finish = Y_finish + extendY;

        % Draw the line connecting the winning marks
        line([X_start, X_finish], [Y_start, Y_finish], 'Color', conColor, 'LineWidth', weight * 0.75);

        % Display winning statement
        text(0, 0, statement, 'FontSize', 57, 'Color', winTextColor, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle')
    end

    hold off;

    % Set figure title
    title('TIC TAC TOE');
end

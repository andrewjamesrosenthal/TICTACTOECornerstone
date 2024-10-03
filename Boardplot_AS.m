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




function [] = Boardplot_AS (arr, winner, start, finish)
    clf;
    hold on

    % turn off ticks
    set(gca, 'XTick',[],'YTick',[]);

    % board style variables
    weight = 7.5;
    gridColor = 'k';
    xColor = 'r';
    oColor = 'b';
    winTextColor = 'g';  % color of connecting line after winning
    POC = 0.7;  % percent of cell filled by markers

    % board
    % plotting variable
    lef = - 1.5;
    top = 1.5;
    spacing = 1;
    
    % setting the viewport
    axis square
    axis([lef-0.33*spacing lef+3.33*spacing top-3.33*spacing top+0.33*spacing])

    % printing the grid
    line([lef, lef + 3*spacing], [top - spacing, top - spacing], 'Color', gridColor, 'LineWidth', weight)
    line([lef, lef + 3*spacing], [top - 2*spacing, top - 2*spacing], 'Color', gridColor, 'LineWidth', weight)
    line([lef + spacing, lef + spacing], [top, top - 3*spacing], 'Color', gridColor, 'LineWidth', weight)
    line([lef + 2*spacing, lef + 2*spacing], [top, top - 3*spacing], 'Color', gridColor, 'LineWidth', weight)
    
    % printing col indicators
    rowValues = ['A', 'B', 'C'];
    for i = 1 : 3
        % col labels
        text(lef + spacing*(i+0.5 - 1), top + spacing / 5, string(i), 'Color', gridColor,'FontSize',20);
        % row labels
        text(lef - spacing / 4, top - spacing*(i + 0.5 - 1), rowValues(i), 'Color', gridColor,'FontSize',20);
    end
    
    % loop through all cells of the mark array
    for i = 1:size(arr, 2)
        % getting center coords of the current cell
        X = lef + spacing*(0.5+mod(i-1, 3));
        Y = top - spacing*(0.5+floor((i-1)/3));
        % check if is an 'X'
        if arr(i) == 1
            % draws x
            line([X, X] + spacing*[-POC POC]/2, ...
                repelem(Y, 2, 2) + spacing*[-POC POC; POC -POC]/2, ...
                'color', xColor, 'LineWidth', weight);
        % check if is an 'O'
        elseif arr(i) == 2
            % draws o
            rectangle('Position', [X-POC/2 Y-POC/2 POC POC], 'Curvature', [1, 1], ...
                'EdgeColor', oColor, 'LineWidth', weight);
        end
    end

    % Win screen
    if winner ~= 0
        % customize output based on who won
        if winner == 1
            statement = 'X Wins!';
            conColor = xColor;
        else
            statement = 'O Wins!';
            conColor = oColor;
        end
        
        % connect winning marks
        % convert start and finish cells to row and cols
        srow = floor((start - 1) / 3);
        scol = mod(start - 1, 3);
        frow = floor((finish - 1) / 3);
        fcol = mod(finish - 1, 3);

        % set start and end points of connecting line from start and finish
        if (scol ~= fcol)
            X = [lef lef+3*spacing];
        else
            X = repelem(lef+(scol+0.5)*spacing, 2);
        end
        if (srow ~= frow)
            Y = [top top-3*spacing];
        else
            Y = repelem(top-(srow+0.5)*spacing, 2);
        end
        % draw line
        line(X, Y, 'Color', conColor, 'LineWidth', weight*0.75)
        % winning statement
        text(0, 0, statement, 'FontSize', 57, 'Color', winTextColor, 'HorizontalAlignment','center','VerticalAlignment','middle')
    end
    
    hold off;
    
    % sets figure title
    title('TIC TAC TOE');
end
function [] = Boardplot_AS (arr, winner, start, finish)
    clf;
    hold on

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
        line([lef lef+3*spacing], [top top-3*spacing], 'Color', conColor, 'LineWidth', weight*0.75)
        % winning statement
        text(-1, 0, statement, 'FontSize', 57, 'Color', 'g')
    end
    
    hold off;
end
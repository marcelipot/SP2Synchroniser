function X = naninterp(X, method)

    % Interpolate over NaNs
    % See INTERP1 for more info
    %   Input:
    %       X: Matrix containing NaN to replace
    %       method: 'linear', 'nearest', 'next', 'previous', 'pchip', 'cubic', 'v5cubic', 'makima', 'spline'
    %   Output:
    %       X: Matrix with NaN replaced
    %
    % (c) copyright Marc Elipot, 2012
    
    X(isnan(X)) = interp1(find(~isnan(X)), X(~isnan(X)), find(isnan(X)), method, 'extrap');
    
return
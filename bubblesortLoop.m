% Bubblesort for loop
% Any A can be plugged into it 
A = [600 7000 0 -662 8 -12 -90 88 45]
N = length(A)
for j = 1:N
    for i = 1:N-1
        if A(i+1) < A(i)
            temp = A(i)
            
            A(i) = A(i+1)
            disp(A)
            A(i+1) = temp
            disp(A)
        else
            %else will execute if statement is false
            disp("No Swap")
            disp(A)
        end
    end
end
disp("The bubblesort for this array is =")
disp(A)
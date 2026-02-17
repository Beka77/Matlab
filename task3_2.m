x = input('Введите число x: ');
y = input('Введите 25 чисел в виде вектора [y1 y2 ... y25]: ');

if numel(y) ~= 25
    error('Нужно ввести ровно 25 чисел.');
end

[iBest, jBest, yBest1, yBest2, bestMean, minDiff] = closest_mean_pair(x, y);

fprintf('Лучшие элементы: y(%d)=%.6g и y(%d)=%.6g\n', iBest, yBest1, jBest, yBest2);
fprintf('Их среднее арифметическое: %.6g\n', bestMean);
fprintf('|mean - x| = %.6g\n', minDiff);
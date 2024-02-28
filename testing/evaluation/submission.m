function submission(t1, t2, t3, t4, t5)
    t1 = renamevars(t1,["Var1"],["task1"]);
    t2 = renamevars(t2,["Var1"],["task2"]);
    t3 = renamevars(t3,["Var1"],["task3"]);
    t4 = renamevars(t4,["Var1"],["task4"]);
    t5 = renamevars(t5,["Var1"],["task5"]);
    
    sub = [t1 t2 t3 t4 t5];
    writetable(sub,'submission.csv');
end
function [score] = calculate_score(answers, prediction_1, prediction_2, prediction_3, prediction_4, prediction_5)

score= 0;
max_score= 0;

prediction_1 = renamevars(prediction_1,["ID", "Var1"], ["ID", "Task1"]);
prediction_2 = renamevars(prediction_2,["ID", "Var1"], ["ID", "Task2"]);
prediction_3 = renamevars(prediction_3,["ID", "Var1"], ["ID", "Task3"]);
prediction_4 = renamevars(prediction_4,["ID", "Var1"], ["ID", "Task4"]);
prediction_5 = renamevars(prediction_5,["ID", "Var1"], ["ID", "Task5"]);

score1 = [answers.("Spacecraft No."), (prediction_1.Task1 == answers.task1)];
for i=1:length(score1)
    if score1(i,2)==1
        if score1(i,1)==4        
            score = score+20;
        else 
            score = score+10;
        end
    end
end

score2 = [answers.("Spacecraft No."), (prediction_2.Task2 == answers.task2)];
for i=1:length(score2)
    if table2array(answers(i,"task2")) ~= 0 && score2(i,2)==1
        if score2(i,1)==4        
            score = score+20;
        else 
            score = score+10;
        end
    end
end

score3 = [answers.("Spacecraft No."), (prediction_3.Task3 == answers.task3)];
for i=1:length(score3)
    if table2array(answers(i,"task3")) ~= 0 && score3(i,2)==1
        if score3(i,1)==4        
            score = score+20;
        else 
            score = score+10;
        end
    end
end

score4 = [answers.("Spacecraft No."), (prediction_4.Task4 == answers.task4)];
for i=1:length(score4)
    if table2array(answers(i,"task4")) ~= 0 && score4(i,2)==1
        if score4(i,1)==4        
            score = score+20;
        else 
            score = score+10;
        end
    end
end

score5 = [answers.("Spacecraft No."), prediction_5.Task5, answers.task5];
for i=1:length(score5)
    if score5(i,3) ~= 100 
        s = max(-abs(score5(i,2)-score5(i,3))+20, 0);
        if score4(i,1)==4        
            score = score+(s*2);
        else 
            score = score+s;
        end
    end
end


% calcolo punteggio massimo 
for i=3:width(answers)-1
    for j=1:height(answers)
        if i==3 
            % punteggio task 1
            if table2array(answers(j,"Spacecraft No.")) == 4
                max_score = max_score+20;
            else
                max_score = max_score+10;
            end
        elseif i == width(answers)-1
            % punteggio task 5
             if table2array(answers(j,i)) ~= 100
                if table2array(answers(j,"Spacecraft No.")) == 4
                    max_score = max_score+40;
                else
                    max_score = max_score+20;
                end
            end
        else
            if table2array(answers(j,i)) ~= 0
                if table2array(answers(j,"Spacecraft No.")) == 4
                    max_score = max_score+20;
                else
                    max_score = max_score+10;
                end
            end
        end
    end
end

score = score/max_score*100;

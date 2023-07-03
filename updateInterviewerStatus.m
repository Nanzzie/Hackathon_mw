function updateInterviewerStatus(ID, status)
    if strcmp(status,'Go') || strcmp(status,'Busy') || strcmp(status,'Meet')
        Int = load("Interviewers.mat", "Int").Int;
        Int.Status(Int.ID == ID) = {status};
        save("Interviewers.mat","Int")
    end
end
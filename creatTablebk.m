function freeSlots = createTable(currentTime)
    slots = readmatrix(convertStringsToChars("test/Scheduling/data/output/slotting/"+ string(getlatestfile('test/Scheduling/data/output/slotting/'))));
    slots(:,1) = [];
    slots(:,4) = zeros(length(slots),1);
    slots(slots(:,2)<=16,4) = 1;
    slots(slots(:,2)>=17 & slots(:,2)<=23,4) = 2;
    slots(slots(:,2)>=24,4) = 3;
    Int = load("Interviewers.mat", "Int").Int;
    freeSlots = Int.Free(:,currentTime+1:end);
    for i = 1:length(slots)
        sID = slots(i,1);
        iID = slots(i,2);
        slot = slots(i,3);
        type = slots(i,4);
        if type == 1
            availableSlots = find(freeSlots(iID,:));
            if (slot-1)*4+1 > length(availableSlots)
            else
               
               index = availableSlots((slot-1)*4+1);
               if freeSlots(iID,index) == 1
                    freeSlots(iID,index:index+3) = sID;
               else
                   while true
                        slot = slot+1;
                        if (slot-1)*4+1 > length(availableSlots)
                            break
                        else
                           
                           index = availableSlots((slot-1)*4+1);
                           if freeSlots(iID,index) == 1
                                freeSlots(iID,index:index+3) = sID;
                                break
                           end
                        end

                   end
               end
            end
            
        end
        if type == 2
            availableSlots = find(freeSlots(iID,:));
            if (slot-1)*2+1 > length(availableSlots)
            else 
               index = availableSlots((slot-1)*2+1);
               freeSlots(iID,index:index+1) = sID;
            end
            
        end
        if type == 3
            availableSlots = find(freeSlots(iID,:));
            if (slot-1)*1+1 > length(availableSlots)
            else 
               index = availableSlots((slot-1)*1+1);
               freeSlots(iID,index) = sID;
            end
            
        end
        
    end
    Int.Free(:,currentTime+1:end) = freeSlots;
    save("Interviewers.mat", "Int")
end
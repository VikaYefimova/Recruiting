public class HelperForAssigningPositionTrigger {
    public void assignPosition(List<Position__c> positions){
        Position__c[] newPositions = new Position__c[]{};
        for(Position__c newPos : positions){
            User positionOwner = [select ProfileId from User where id =: newPos.OwnerId];
            id ownerProfileId = positionOwner.ProfileId;
            String ownerProfileName = [select Name from Profile Where id =: ownerProfileId].Name;
            
            if(!ownerProfileName.contains('Recruiter')){
                Group queue = [Select Id from Group WHERE Type LIKE 'Queue' AND Name LIKE 'Unclaimed Positions' LIMIT 1];
                Position__c newPosition = new Position__c(Id=newPos.Id);
                newPosition.OwnerId = queue.id;
                newPositions.add(newPosition);
               }
            }
                try{
                    update newPositions;
                }
                catch(DmlException ex){	// let's cover this part of code as well (just to practise, how to do it).
                    System.debug(ex.getMessage());
                }
    }
}
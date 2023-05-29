public with sharing class database101 {
public Id insertStudent(String name, String email) {
    // #126 
    apxio__Student__c obj = new apxio__Student__c();
    
    obj.Name = name;
    obj.apxio__Email__c = email;
    
    insert obj;
    return obj.Id;
}

public Id insertCourse(String name, String details, Integer credits) {
    // #132 insert course with limited to picklist values
    Set<Integer> picklistValues = new Set<Integer>{
        1,2,3,4 };
    if (picklistValues.contains(credits)){
        apxio__Course__c c = new apxio__Course__c();
        c.Name = name;
        c.apxio__Course_Details__c = details;
        c.apxio__Credits__c = String.valueOf(credits);
        insert c;
        return c.Id;
    } else {
        return null;
    }
}
public String registerStudent(String name, String phone, String email) {
    // #127 - Register Student
    apxio__Student__c s = new apxio__Student__c();
    s.name = name;
    s.apxio__Phone__c  = phone;
    s.apxio__Email__c = email;
    insert s;
    
    apxio__Student__c rec = [
        SELECT apxio__Registration_Number__c
        FROM apxio__Student__c
        WHERE apxio__Student__c.Id = :s.Id
    ];
    
    return rec.apxio__Registration_Number__c;

}    

public List<apxio__Student__c> selectActiveStudents() {
    // #128 - Active Students
    List<apxio__Student__c> activeStudents = [
        SELECT Id, Name
        FROM apxio__Student__c
        WHERE apxio__Active__c=True
    ];
    return activeStudents;    
}
public List<apxio__Student__c> selectUnreachableStudents() {
    // #130 - Unreachable Students: they are missing both an email and a phone number but active
    // The method should return a list with a single record for Paulina Smith
    List<apxio__Student__c> unreachableStudents = [
        SELECT Id, Name
        FROM apxio__Student__c
        WHERE apxio__Active__c=True
        AND apxio__Phone__c=null
        AND apxio__Email__c=null
        ORDER BY Name
    ];
    return unreachableStudents;    
}
public List<apxio__Student__c> selectStudentsWithoutContactInfo() {
    // #129 - Students Missing Info
    List<apxio__Student__c> studentsMissingInfo = [
        SELECT Id, Name
        FROM apxio__Student__c
        WHERE apxio__Active__c=True 
        AND (apxio__Phone__c=null
        OR apxio__Email__c=null)
        ORDER BY Name
    ];
    return studentsMissingInfo;      
}

public void createCourseAndClass(String name, String description) {
    // #131
    if (name == null) {
        name = '';
    }
    if (description == null) {
        description ='';
    }

    apxio__Course__c course = new apxio__Course__c();
    course.Name = name;
    course.apxio__Course_Details__c = description;
    insert course;

    apxio__Class__c classInsert = new apxio__Class__c();
    classInsert.Name = name;

    //  Make sure to truncate the description to 255 characters before adding it to your apxio__Class__c record. 
    if(description.length() > 255 ){
        String descTruncated = description;
        descTruncated = description.substring(0, 255);
        classInsert.apxio__Description__c = descTruncated;
    } else {
        classInsert.apxio__Description__c = description;
    }
    // Class is a child of Course related through the apxio__Course__c field.
    // Once you have inserted an apxio__Course__c, copy the Id value into the apxio__Course__c field on the new apxio__Class__c record.
    classInsert.apxio__Course__c = course.Id;
    insert classInsert;
}
public void insertStudents(List<String> studentNames, List<String> studentEmails) {
    // #133 - Student List
    List<apxio__Student__c> stuList = new List<apxio__Student__c>();

    for (Integer i = 0; i < studentNames.size(); i++) {
        apxio__Student__c s = new apxio__Student__c();
        s.Name = studentNames[i];
        s.apxio__Email__c = studentEmails[i];
        stuList.add(s);
    }
    
    insert stuList;
}
public Id classFromCourse(String courseName) {
    // #134 - Class from CourseYou should not create a new apxio__Course__c record. The new class should be linked to the course that already exists in the database. In case no course with the given name is found, do not create any class record and return null.
    List<apxio__Course__c> courseList = [
        SELECT Id, Name
        FROM apxio__Course__c
        WHERE apxio__Course__c.Name= :courseName
        LIMIT 1
    ];
    Boolean noCourseFound = (courseList.size()<1);
    if (noCourseFound) {
        return null;
    } else {
        // #131 ex create class course return course id
        List<apxio__Class__c> classInsertList = new List<apxio__Class__c>();
        for (Integer i = 0; i < courseList.size(); i++) {
            apxio__Class__c classInsert = new apxio__Class__c();
            classInsert.name = courseList[i].Name;
            classInsert.apxio__Course__c = courseList[i].Id;
            classInsertList.add(classInsert);
        }
        insert classInsertList;                
        // notice LIMIT 1 on the query so there is only one record
        return classInsertList[0].Id;
    }
}

public void enrollStudents(List<String> emails, String className) {
    // #135 - Enroll Students
    List<apxio__Student__c> stuList = [
        SELECT Id, apxio__Email__c
        FROM apxio__Student__c
        WHERE apxio__Email__c IN:emails
    ];        
    // only one element on the list expected due to unique name req't
    List<apxio__Class__c> clsList = [
        SELECT Id, Name
        FROM apxio__Class__c
        WHERE Name =: className
    ];

    List<apxio__Class_Enrollment__c> enrList = new List<apxio__Class_Enrollment__c>();

    // iterate thru students and enroll each of them to the same class by using Id as Foreign Key to tables
    for (Integer i = 0; i < stuList.size(); i++) {
        apxio__Class_Enrollment__c enr = new apxio__Class_Enrollment__c();
        enr.apxio__Offered_Class__c = clsList[0].Id;
        enr.apxio__Student__c = stuList[i].Id;
        enrList.add(enr);
    }
    insert enrList;
}
}

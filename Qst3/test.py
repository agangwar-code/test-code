def return_value(object, key, empty_list):
    if not isinstance(object, dict):
        print("passed nested object is not valid")
        exit()

    key_list=key.split("/")   #converting the key elements into a list

    for i,j in object.items():
        if not isinstance(i, str):
            i=str(i) #Any datatybe will be converted to string 

        if i in key:
            i_list=i.split() #it will allow to keep the whole word as an element of string
            empty_list.extend(i_list) #Concatenating the string to form a list
            if key_list == empty_list: 
                print(j)
           
        if isinstance(j, dict):
            return_value(j, key ,empty_list)

##Sample Values##
object = {"abc":{"bcd":{"cfg":"d"}}}
key = "abc/bcd/cfg"
empty_list=[]
return_value(object, key, empty_list)


#!/usr/bin/env python
# coding: utf-8

# #### Function definition
# ##### Block of code that performs a specific task. Helps in reusing code, organizing code and improving readability

# In[ ]:


## syntax 
def function_name(parameters):
    """ Docstring """
    # Function body 
    return expression


# In[1]:


def even_or_odd(num):
    """This function checks if num is even or odd"""
    if num % 2 == 0:
        print("The number is even")
    else:
        print("The number is odd")


# In[3]:


#calling the function - using the function
even_or_odd(15)
even_or_odd(30)


# In[4]:


#functions with mutiple parameters

def add(a,b):
    return a + b

result = add(5,2)
print(result)


# In[10]:


# default parameters

def greet(name= "Guest"):
    print(f"Welcome {name} to Functions in python")

#calling
greet()
greet("Brenda")


# In[12]:


#variable length arguements
#positional vs keyword arguements

#positional arguements

def print_numbers(*args): # allows for mutiple positional arguements
    for number in args:
        print(number)


# In[13]:


print_numbers(1,2,3,4,5,6,7,8,9,"args") # are positional arguements referenced by *args


# In[14]:


#keyword arguements - all the parameters are in the value of key value pairs
def print_details(**kwargs):
    for key,value  in kwargs.items():
        print(f"{key}: {value}")


# In[16]:


print_details(name = "Brenda", age = 25, country = "Kenya")


# In[17]:


#combo of positional and keyword arguements
def print_details(*args, **kwargs): 
    for val in args:
        print(f"Positional arguement : {val}")

    for key,value  in kwargs.items():
        print(f"{key}: {value}")
    


# In[18]:


print_details(1,2,3, name = "Brenda", age = 25, country = "Kenya")


# In[2]:


# return statements
def multiply(a,b):
    return a*b,a  # can return mutiple statements

multiply(5,20)


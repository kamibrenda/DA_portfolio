#!/usr/bin/env python
# coding: utf-8

# ##### The fiter() function constructs an iterator from elements of an iterable for which a function returns true. It is used filter out items from a list based on a condition 

# In[1]:


def even(num):
    if num%2==0:
        return True
    
even(24)


# In[2]:


lst = [1,2,3.4,5,6,7,8,9,10,11,12]

list(filter(even,lst)) #returns only elements that satisfies the condition


# In[3]:


#filter with a lambda function
numbers =[1,2,3,4,5,6,7,8,9]
greater_than_five=list(filter(lambda x:x>5, numbers))
print(greater_than_five)


# In[5]:


## filter with lambda function with mutiple conditions
numbers =[1,2,3,4,5,6,7,8,9]
even_and_greater_than_five = list(filter(lambda x:x>5 and x%2==0, numbers))
print(even_and_greater_than_five)


# In[10]:


## filter with dictionaries
#used to check if age is greater than 25
def is_age_above_22(person):
    return person['age'] > 22

people=[
    {'name':'Brenda', 'age': 25},
    {'name':'Michelle ', 'age': 23},
    {'name': 'Christine', 'age': 22},
    {'name': 'Joy', 'age': 21},
    {'name': 'Ivy', 'age': 11}
]

filtered_ages = list(filter(is_age_above_22,people))
print(filtered_ages)


# In[11]:


#filter with dictionary and lambda function
check_people = list(filter(lambda people: people["age"] > 22, people))
print(check_people)


# In[1]:


## converted this file into .py from ipynb
#jupyter nbconvert --to script filter.ipynb


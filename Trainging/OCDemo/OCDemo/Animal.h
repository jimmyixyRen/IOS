//
//  Animal.h
//  OCDemo
//
//  Created by rendl on 15/1/5.
//  Copyright (c) 2015年 BIS_developer. All rights reserved.
//

#ifndef __OCDemo__Animal__
#define __OCDemo__Animal__

#include <stdio.h>

typedef enum AnmialType{
    AT_MEAT = 1,
    AT_PLANT
} AnimalType;


class Animal
{
  
    public:
    char *name;
    AnmialType type;
    
    void doAction();
};

#endif /* defined(__OCDemo__Animal__) */

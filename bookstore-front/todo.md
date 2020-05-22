#TODO Flow

- Angular route guards  
  - See what options are there
  - Select option
  - Apply route guards to all pages according to the rules
    - If user and admin show stuff differently
    - show different components, or same components but different visibility?
      - different visibility is too much stuff on the view
      - different components based on role is too much components
    - on the other hand different components by role is easier to make fast.
    
So Route Guards are generally working now...    

TABLE INITIALIZED

Display Inventory TODO

Load articles into db... HELL MY MAPPEDSUPERCLASS IS STILL NOT WORKING...
Turns out, it was working, but i was expecting it would get me an Articles JpaRepo..
Nope...

DID I DECIDE TO GO WITH NGRX?!


Articles are available on REST

Get them into Front, attach to the table, get sorting and shit done...

What to do now?

Add subclass type to back-end response
http://www.davismol.net/2015/03/05/jackson-json-deserialize-a-list-of-objects-of-subclasses-of-an-abstract-class/

Add front-end deserialization


export interface tool {
    type: string;
    name: string;
    draw(context:any): void;
}

class textTool implements tool {
    type:string = 'textTool';
    name:string;
    fontSize:number;
    fontType:string;

    draw(context:any):void {
    }
}

const typeMapping:any = {
    'textTool' : textTool
    //all other types
};
let elements: Array<tool> = JSON.parse(json).map((i:any) => {
    let target:any = new typeMapping[i.type];
    for (const key in i) {
        target[key] = i[key];
    }
    return target;
});

//TODO


enum Category { CAT, DOG }

enum Condition { Adoption, Disappear }

class Pet {
  String name;
  String location;
  //String distance;
  //String condition;
  Category category;
  String imageUrl;
  bool favorite;
  bool newest;

  Pet(this.name, this.location, this.category, this.imageUrl, this.favorite,
      this.newest);
}

List<Pet> getPetList() {
  return <Pet>[
    Pet("cat", "Palestine", Category.CAT, "assets/img/cat1.jpg",
        false, false),
    Pet("dog", "Palestine", Category.DOG, "assets/img/dog1.jpg",
        true, true),
    
  ];
}

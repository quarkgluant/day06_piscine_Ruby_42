# day06 de la piscine Ruby/Rails de 42 Paris
le jour 06 de la piscine Ruby de 42 refait/day06 of the 42 swimming pool Ruby/rails  
  
## Salut à toi duoquadratain qui se retrouve tout seul à faire la piscine Ruby !  
  
  
### Tes meilleurs amis  
les [railsguides](https://guides.rubyonrails.org/) pour des explications d'ensemble et la doc de l'[API](https://api.rubyonrails.org/) pour de la doc sur une méthode précise.  
  
Mais aussi:  
Une très bonne adresse en français [grafikart](https://www.grafikart.fr/tutoriels/ruby-on-rails)  
L'excellent [Rails tutorial](https://www.railstutorial.org/book) de Michael Hartl  
[goRails](https://gorails.com/series), d'autant qu'avec le GitHub Student Pack, on bénéficie d'un abonnement d'un an gratos  
[RailsCast](http://railscasts.com/)  
ton cerveau, il peut servir...    
  
### Avant de coder, installons !  
Avant toute chose et tout code, il vous faut utiliser un gestionnaire de version de Ruby (et donc de Rails) [RVM](https://rvm.io/) et [rbenv](https://github.com/rbenv/rbenv#readme) étant les plus connus et utilisés, mais existe aussi chruby, uru, etc.  
  
Avec RVM, on installe la version de Ruby désirée, en regardant sur [site officel de Ruby](https://www.ruby-lang.org/en/downloads/releases/) les versions de Ruby (`rvm install 2.6.5` par exemple), créer un gemset (un environnement isolé) avec `rvm gemset create nom_du_gemset`, je nomme en général mes gemsets avec la version de Ruby@rails_version, par ex `rvm gemset create 2.6.5@rails4.2.7`.  
Une fois le gemset créé, on rentre dedans/l'utilise avec `rvm 2.6.5@rails4.2.7` dans cet exemple et ensuite, seulement on installe rails avec la bonne version avec `gem install rails  -v 4.2.7 -no-ri -no-rdoc` sans la doc incluse  


outre le code de ce repo voici quelques pistes pour t'aider:  

### ex00  

Pour commencer voici des ressources sur l'inscription et l'authentification d'utilisateur, faites à la main, donc sans la gem la plus connue qui fait cela très bien, **Devise**  
* [un épisode de Railcast (en)](http://railscasts.com/episodes/250-authentication-from-scratch-revised)  
* [un tuto/gist bien fait (en)](https://gist.github.com/iscott/4618dc0c85acb3daa5c26641d8be8d0d)  
* [un article de Medium (en)](https://medium.com/@ColeHall/rails-authorization-without-using-3rd-party-gems-47545c694343)  
  
  
### ex01  
Pour l'ex01, voici un extrait du livre di livre *Agile Web Development with Rails 5.1*  de Sam Ruby, David Bryant Copeland, with Dave Thomas  

> Rails does this using a simple naming convention. If an incoming request has a controller named (say) admin/book, Rails will look for the controller called book_controller in the directory app/controllers/admin. That is, the final part of the controller name will always resolve to a file called name_controller.rb, and any leading path information will be used to navigate through subdirectories, starting in the app/controllers directory.

> Imagine that our program has two such groups of controllers (say, admin/xxx and content/xxx) and that both groups define a book controller. There’d be a file called book_controller.rb in both the admin and content subdirectories of app/controllers. Both of these controller files would define a class named BookController. If Rails took no further steps, these two classes would clash.

> To deal with this, Rails assumes that controllers in subdirectories of the directory app/controllers are in Ruby modules named after the subdirectory. Thus, the book controller in the admin subdirectory would be declared like this:

> 
```ruby
​ 	​class​ Admin::BookController < ActionController::Base
​ 	  ​# ...​
​ 	​end​
```
> The book controller in the content subdirectory would be in the Content module:
```ruby
​ 	​class​ Content::BookController < ActionController::Base
​ 	  ​# ...​
​ 	​end​
```

Pour les non-Rubyiste, il faut savoir que
```ruby
	module Foo # ou class Foo
	  class Bar
	  # ...
	  end
	end
```
est équivalent à:  
```ruby
class Foo::Bar
``` 
pour les curieux [question sur Stackoverflow](https://stackoverflow.com/questions/7821459/whats-the-difference-between-these-ruby-namespace-conventions)  
  
### le reste !  
Je vous conseille d'utiliser les commandes `rails g`  (raccourci de `rails generate`). Les exemples donnés ci-dessous ne correspondent pas forcèment à votre exo/app...  
tels 
* `rails g scaffold Post user:references title:string content:text` qui code *presque* tout à votre place  
* `rails g scaffold_controller Admin::Votes`  
* `rails g model Vote user:references post:references value:integer` pour les modèles
* `rails g migration AddIndexToTitleToPost`, `rails g migration AddFullnameToUser fullname:string` pour les migrations  
* `rails g controller session log_in log_out`
* `rails g -h` et `rails g *objet/choix possible* -h` pour l'aide

Je suis en train de refaire ce jour 06, pour l'instant les ex00 à ex04 inclus sont finis, en respectant les consignes et les **Rails Best Practices** et score **Rubycritic** supérieur à 90
manquent encore des seeds pour les exos 2 à 5 et surtout les **tests**  

P.S. Une petite étoile pour remercier fait toujours plaisir
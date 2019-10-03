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
  
  
##### quelques petits points:  
* l'utilisation de `has_secure_password` dans le modèle User
* l'utilisation de `helper_method`, dans application_controller, qui permet non seulement de partager ces méthodes entre
tous les contrôleurs mais aussi les vues. Pour rappel, les méthodes définies dans les helpers servent, elles, dans les vues. 
Vu que le snippet de code fourni dans le sujet (fourni en sept 2017) ne marche plus, j'ai utilisé un petit bout de code 
simplissime ([].sample)  
* la syntaxe d'expiration du cookie `expires: 1.minute` ne fonctionnant pas (dans users_controller#home), j'utilise
`expires: Time.current + 1.minute`
* l'utilisation de filtres dans app/models/user.rb tel que `before_save { self.email = email.downcase }` pour mettre en 
minuscule avant de sauvegarder dans la base de données   

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

attention à bien définir vos routes (app/config/routes), j'ai utilisé (la syntaxe %i[] permet de définir un array de symboles)
```ruby
  namespace :admin do
    resources :users, except: %i[new create]
  end
```  

## ex02  
pensez aux associations dans vos modèles (`belongs_to :modèle_AU_SINGULIER et have_many :modèles_AU_PLURIEL`) et à 
scaffolder pour créer Post `rails g scaffold Post user:references title:string content:text` qui code *presque* 
tout à votre place  
  
##### petits points:  
* A noter dans app/models/post.rb
```ruby
delegate :name, to: :user, prefix: true
```  
qui permet de remplacer ici dans les vues `@post.user.name` qui fait couiner Rails best practices par `@post.user_name`
* l'utilisation de partials dans les vues. Pour rappel on les appelle/affiche avec cette ligne dans une vue
```erbruby
<%= render 'Chemin_relatif(si besoin)/nom_du_partial', post: @post %>
# ou si le partial n'est pas dans un sous dossier
<%= render 'nom_du_partial', post: @post %>
```  
et leurs fichiers commencent TOUJOURS par un **_**, ici le fichier serait `_nom_du_partial.html.erb`. Ici on passe un 
argument (:post) qui permet dans le partial d'utiliser directement `post` à la place de `@post`. Heureusement, car utiliser
@post dans le partial fait (encore) râler Rails best practices !  
  
## ex03  
J'ai choisi d'implémenter la fonctionnalité en rajoutant un champ `edit_by_user_id` dans la table `posts` (avec bien-sûr 
une migration) et en utilisant, bien-sûr, le champ `updated_at`  de la même table.  

## ex04  
Ha là on tape dans le `has_many through:` comme association dans le modèle User.  
J'ai utilisé encore le namespacing pour 
le contrôleur app/controllers/posts/votes_controller.rb (`class Posts::VotesController`) et pour la vue avec partial
app/views/posts/votes/_votes.html.erb qui est "appelé" dans le posts/show.html.erb (ce qui s'avèrera très pratique pour 
le dernier exo !). Le contrôleur votes_controller.rb n'a qu'une méthode create. celui d'admin possède en plus une méthode 
destroy et une méthode index.
```ruby
# extrait de la méthode create de posts/votes_controller.rb
vote = @post.votes.where(user_id: current_user.id).first_or_create
    # value = vote.value + params[:value].to_i
    vote.update_attributes(value: params[:value])
```
`first_or_create` cherche dans la table si le vote existe et s'il n'existe pas le crée. J'ai décidé qu'un utilisateur ne
 peut voter qu'une fois par Post (d'où la seconde ligne commentée ci-dessus). la valeur du vote (+1 ou -1) est envoyée 
 dans params pour l'upvote (le downvote se fait de la même façon avec la value: -1) par:
 ```erbruby
# app/views/posts/votes/_votes.html.erb
 #... 
<%= button_to 'Upvote', post_vote_path(post), method: :post, params: {value: 1} %>
```
puisque ce n'est pas un form(ulaire), pas besoin de strong_parameters, just `params[:value]`  

## ex05  
Ici on mime un peu la célèbre gem **CanCanCan** (ou **Pundit**). Mais finalement, j'ai fait un truc très simple: 
une méthode dans application_helper.rb `know_your_rights(user)` pour renvoyer en fonction du user ses droits et une 
autre méthode (une helper_method) `count_current_user_votes` (pas besoin d'expliquer ce q'elle fait!) dans application_controller.rb. Ensuite je fais juste des if
dans les vues pour afficher ou pas, par ex:  
`<%= render partial: '/posts/votes/votes', locals: { post: @post, somme: @somme } if count_current_user_votes >= 3 %>`

### le reste !  
Je vous conseille d'utiliser les commandes `rails g`  (raccourci de `rails generate`). Les exemples donnés ci-dessous 
ne correspondent pas forcèment à votre exo/app...  
tels 
* `rails g scaffold Post user:references title:string content:text` qui code *presque* tout à votre place  
* `rails g scaffold_controller Admin::Votes`  
* `rails g model Vote user:references post:references value:integer` pour les modèles
* `rails g migration AddIndexToTitleToPost`, `rails g migration AddFullnameToUser fullname:string` pour les migrations  
* `rails g controller session log_in log_out`
* `rails g -h` et `rails g *objet/choix possible* -h` pour l'aide

Je suis en train de refaire ce jour 06, pour l'instant tous les exos sont finis, en respectant les consignes et les **Rails Best Practices** et score **Rubycritic** supérieur à 90
manquent encore des seeds pour les exos 2 à 5 et surtout les **tests**  

> quarkgluant/pcadiot  
> octobre 2019  
> Paris  

P.S. Une petite étoile pour remercier fait toujours plaisir **SI** ce document vous a été utile
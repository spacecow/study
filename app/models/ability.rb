class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Glossary
    can :read, Sentence
    can :read, Kanji

    if user
      can [:create,:update], Glossary
      can [:create,:update], Sentence
      can :update, Kanji
      can :show, User
      can :destroy, [SynonymGlossary,SimilarGlossary,AntonymGlossary]
      can :destroy, Similarity
      if Authorization.role?(user,:admin)
        can :manage, :all
        #can [:index, :create, :update_multiple], Translation
        #can [:create, :update], Project
      end
    end
  end
end

# See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
# If you pass :manage it will apply to every action. Other common actions here are
# :read, :create, :update and :destroy.

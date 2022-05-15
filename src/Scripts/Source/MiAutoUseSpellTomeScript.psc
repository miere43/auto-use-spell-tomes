ScriptName MiAutoUseSpellTomeScript Extends ReferenceAlias

Event OnInit()
	RegisterForSingleUpdate(1)
EndEvent

Event OnUpdate()
	GoToState("Ready")
EndEvent

State Ready
	Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
		Book bookRef = akBaseItem as Book
		If !bookRef
			Return
		EndIf

		Spell bookSpell = bookRef.GetSpell()
		If !bookSpell
			Return
		EndIf

		Actor actorRef = GetReference() As Actor
		If actorRef.AddSpell(bookSpell, false)
			actorRef.RemoveItem(akBaseItem, 1, true)
			UISpellLearnedSound.Play(actorRef)
			Debug.Notification("New Spell Learned: " + bookSpell.GetName())
		EndIf
	EndEvent
EndState

Sound Property UISpellLearnedSound Auto

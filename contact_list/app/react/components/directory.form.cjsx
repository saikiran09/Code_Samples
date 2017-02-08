React = require('react')
Reflux = require('reflux')

directoryActions = require('../actions/directoryActions.cjsx')

DirectoryForm = React.createClass
    mixins: [Reflux.ListenerMixin]

    componentDidMount: () ->
        @listenTo(directoryActions.editEntry, (person) -> @_handleEditEntry(person))

        return

    _handleEditEntry: (person) ->

        @refs.id.getDOMNode().value = person.id
        @refs.name.getDOMNode().value = person.name
        @refs.phone.getDOMNode().value = person.phone
        @refs.email.getDOMNode().value = person.email
        @refs.submit.getDOMNode().value = 'Update'

        return

    _handleSubmit: (e) ->
        e.preventDefault()       

        data =
            id: @refs.id.getDOMNode().value
            name: @refs.name.getDOMNode().value.trim()
            phone: @refs.phone.getDOMNode().value.trim()
            email: @refs.email.getDOMNode().value.trim()

        if (data.name && data.phone)

            if (@refs.id.getDOMNode().value)
                directoryActions.updateEntry(data)

            else
                # OLD WAY
                # Pass data to callback 'this._handleDirectorySubmit'
                # @props.onDirectorySubmit(data)        
                directoryActions.addEntry(data)
        

            # Reset field values after submit
            # @TODO - Extract this to it's own method
            @refs.id.getDOMNode().value = ''
            @refs.name.getDOMNode().value = ''
            @refs.phone.getDOMNode().value = ''
            @refs.email.getDOMNode().value = ''


    render: ->
        <div>
            <form className="addForm" onSubmit={ @_handleSubmit }>
                <input type="hidden" name="id" ref="id" />
                <input type="text" name="name" placeholder="Name" ref="name" />
                <input type="number" name="phone" placeholder="phone" ref="phone" />
                <input type="email" name="email" placeholder="E-mail" ref="email" />
                <input type="submit" value="Add" ref="submit" className="small button" />
            </form>
        </div>

module.exports = DirectoryForm
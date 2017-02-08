React = require('react/addons')
Reflux = require('reflux')
_ = require('lodash')
MD5 = require('md5')

# Directory
directoryActions = require('../actions/directoryActions.cjsx')
DirectoryForm = require('./directory.form.cjsx')

Directory = React.createClass
    mixins: [Reflux.ListenerMixin]

    getInitialState: () ->
        return data: @props.data 

    componentDidMount: () ->
        directoryActions.updateCount(@state.data.length)
        @listenTo(directoryActions.trashEntry, (person) -> @_handleTrashEntry(person))
        @listenTo(directoryActions.addEntry, (person) -> @_handleAddEntry(person))
        @listenTo(directoryActions.updateEntry, (person) -> @_handleUpdateEntry(person))

        return

    _handleTrashEntry: (person) ->
        data = @state.data

        # Remove Person
        _.remove(data, person)

        # Set State to render changes
        @replaceState(data: data)

        # Update Count
        directoryActions.updateCount(data.length)


    _handleAddEntry: (person) ->
        data = @state.data

        # Increment and append Id (used for key)
        lastId = _.max data, (person) ->
            return person.id

        person.id = lastId.id++ or 1
        person.gravatar = ('https://www.gravatar.com/avatar/' + MD5(person.email))

        # Push to data and set State
        @setState(data: React.addons.update(data, { $push: [ person ] }))


        # Update Count
        directoryActions.updateCount(@state.data.length)


    _handleUpdateEntry: (person) ->
        data = @state.data
        
        person.id = parseInt(person.id)
        person.gravatar = ('https://www.gravatar.com/avatar/' + MD5(person.email))
        
        # Find the index Key of the person.id we're trying to edit
        updatePerson = {}

        _.findWhere data, (value, key) ->
            if (value.id == person.id)
                updatePerson[key] = { $merge: person }

        # Make update to this entry alone and set State
        @setState(data: React.addons.update(data, updatePerson))
        document.getElementById('form-header').innerHTML = 'Add an Entry'

    render: ->
        <div className="row">
            <div className="medium-8 columns">
                <h5>Directory</h5>
                <DirectoryList data={ @state.data }></DirectoryList>
            </div>
            <div className="medium-4 columns">
                <h5 id="form-header">Add an Entry</h5>
                <DirectoryForm></DirectoryForm>
            </div>
        </div>


DirectoryList = React.createClass
    render: ->
        people = @props.data.map (person) ->
            <DirectoryItem key={ person.id } person={ person }></DirectoryItem>

        return  <table className="DirectoryList">
                    <thead>
                        <tr>
                            <th></th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        { people}
                    </tbody>
                </table>


DirectoryItem = React.createClass
    _handleTrashEntry: () ->
        directoryActions.trashEntry(@props.person)

    _handleEditEntry: () ->
        document.getElementById('form-header').innerHTML = 'Update Entry'
        directoryActions.editEntry(@props.person)

    render: ->
        <tr className="DirectoryItem">
            <td></td>
            <td className="DirectoryItem__name">{ @props.person.name }</td>
            <td className="DirectoryItem__position">{ @props.person.position }</td>
            <td className="DirectoryItem__email"><a href={ 'mailto:' + @props.person.email }>{ @props.person.email }</a></td>
            <td className="DirectoryItem__action"><a className="trash" onClick={ @_handleTrashEntry }></a></td>
            <td className="DirectoryItem__action"><a className="edit" onClick={ @_handleEditEntry }></a></td>
        </tr>


module.exports = Directory
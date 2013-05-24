/* DYN_RACE_GetObjectID: Gets the object id of an object
* Function is called to live to be able to retrieve unique object identifiers in SP and editor.
*
* Params:
* _object: Object
*
* Returns:
* _unique_object_id: Unique object ID equal on all clients and server.
*/
DYN_RACE_GetObjectID =
{
	_object = _this select 0;
	_unique_object_id = null;
	if(isMultiplayer) then
	{
		_unique_object_id = netId _object;
	}
	else
	{
		_unique_object_id = format["%1",_object];
	};
	_unique_object_id;
};
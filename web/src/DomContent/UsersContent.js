import React from 'react';

function UsersContent(props){
  var tBody = [];
  props.data.forEach(datum => {
    tBody.push(<tr><td> { datum.username } </td><td> { datum.phone } </td><td> { datum.email } </td></tr>)
  });

  return(
    <table className='table is-bordered is-striped is-narrow is-hoverable is-fullwidth'>
      <thead>
        <tr>
          <th> Username </th>
          <th> Phone </th>
          <th> Email </th>
        </tr>
      </thead>
      <tbody>
        { tBody }
      </tbody>
    </table>
  )
}

export default UsersContent;

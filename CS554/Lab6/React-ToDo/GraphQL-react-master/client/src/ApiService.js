/**
 * 
 * Small service for calling GraphQL API server
 */
class ApiService {

    /**
     * define base url and field schemas here
     * @returns {ApiService}
     */
    constructor() {
        this.apiUrl = 'http://localhost:3001/graphql';
        this.userFields = `{id, first_name, last_name, email, department, country, todo_count}`;
        this.todoFields = `{id title completed user {id, first_name, last_name}}`;
    }

    /**
     * Generic function to fetch data from server
     * @param {string} query
     * @returns {unresolved}
     */
    async getGraphQlData(resource, params, fields) {
        const query = `{${resource} ${this.paramsToString(params)} ${fields}}`;
        const res = await fetch(this.apiUrl, {
            method: "POST",
            mode: "cors",
            headers: new Headers({
                "Content-Type": "application/json",
                Accept: "application/json"
            }),
            body: JSON.stringify({ query })
        });
        if (res.ok) {
            const body = await res.json();
            return body.data;
        } else {
            throw new Error(res.status);
        }
      }

      async mutateGraphQlData(resource, params, fields) {
        const query = `mutation {${resource} ${this.paramsToString(
          params
        )} ${fields}}`;
        console.log("query", query);
        const res = await fetch(this.apiUrl, {
          method: "POST",
          mode: "cors",
          headers: new Headers({
            "Content-Type": "application/json",
            Accept: "application/json"
          }),
          body: JSON.stringify({ query })
        });
        if (res.ok) {
          const body = await res.json();
          return body.data;
        } else {
          throw new Error(res.status);
        }
      }

    /**
     * 
     * @param {object} params
     * @returns {array} users list or empty list
     */
    async getUsers(params = {}) {
        const data = await this.getGraphQlData('users', params, this.userFields);
        //return users list
        return data.users;
    }
    async getUserNames(params = {}) {
        const data = await this.getGraphQlData('users', params, `{first_name, last_name, id}`)
        return data.users;
    }

    /**
     * 
     * @param {object} params
     * @returns {array} users list or empty list
     */
    async getTodos(params = {}) {
        const data = await this.getGraphQlData('todos', params, this.todoFields);
        // console.log("here", data.todos);
        //return todos list
        return data.todos;
    }

    async createTodoItem(params) {
        const data = await this.mutateGraphQlData("createTodoItem", params, this.todoFields);
        return data.createTodoItem;
    }

    async deleteTodoItem(params) {
        return await this.mutateGraphQlData("deleteTodoItem", params, "{ id }");
    }
    
    async updateTodoItem(params) {
        const data = await this.mutateGraphQlData("updateTodoItem", params, this.todoFields);
        return data.updateTodoItem;
    }
    
      

    /**
     * 
     * @param {object} params
     * @returns {String} params converted to string for usage in graphQL
     */
    paramsToString(params) {
        let paramString = '';
        if (params.constructor === Object && Object.keys(params).length) {
            let tmp = [];
            for (let key in params) {
                let paramStr = params[key];
                if(paramStr !== '') {
                    if (typeof params[key] === 'string') {
                        paramStr = `"${paramStr}"`;
                    }
                    tmp.push(`${key}:${paramStr}`);
                }
            }
            if (tmp.length) {
                paramString = `(${tmp.join()})`;
            }
        }
        return paramString;
    }

}

export default new ApiService();

// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

export function postData(url, params, auth) {
  return requestData(url, params, 'post', auth)
}

/**
* CRUD Resources using PUT, POST, PATCH, DELETE
* @param {string} url - リクエストURL
* @param {string} params - リクエストパラメータ
* @param {string} method - method
* @returns {Array.<string>} - API返却値
*/
const API_TWEETS = 'https://arcane-ravine-29792.herokuapp.com/api/tweets'
export async function requestData(url, params, method = 'post', auth) {
  let headers = new Headers();

  headers.append('Content-Type', 'application/json');
  headers.append('Accept', 'application/json');

  headers.append('Access-Control-Allow-Origin', 'http://localhost:3000');
  headers.append('Access-Control-Allow-Credentials', 'true');

  headers.append('GET', 'POST', 'OPTIONS');

  headers.append('Authorization', 'Bearer ' + auth);

  const resp = await fetch(
    url,
    {
      method,
      headers,
      body: JSON.stringify(params),
    },
  )
  if (!resp.ok) {
    // rejected
    throw new Error(`Request Failed: ${resp.status}`)
  }
  const json = await resp.json()
  return json
}

document.addEventListener('turbolinks:load', function() {
  // ツイートする
  const tweetButtons = document.querySelectorAll('[id*="js-tweet-btn"]')
  tweetButtons.forEach((btn) => {
    btn.addEventListener('click', async () => {
      const params = {
        text: btn.dataset.title,
        url: btn.dataset.url
      }
      const result = await postData(API_TWEETS, params, btn.dataset.auth)
      // console.log(result)
    })
  })
})
const { Router } = require('express')

const router = Router()

router.get('/', (req, res) => {
    const responseJson = {
        message: 'Hi Golden Owl!',
    }
    res.json(responseJson)
})

module.exports = router

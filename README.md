<a href="https://github.com/jcramm/recordstore-inventory-manager"><img src="https://cdn.pixabay.com/photo/2015/11/07/11/51/phonograph-albums-1031563_1280.jpg"></a>

# Recordstore Inventory Manager

A CLI based Ruby APP for managing a recordstore's inventory built using only core Ruby libraries.
Rubocop and Rspec are included for development purposes.

## Installation

- Clone the repo and import some data and you're ready to go.

### Clone

- Clone this repo to your local machine using `https://github.com/jcramm/recordstore-inventory-manager.git`

## Team

[![FVCproductions](https://avatars3.githubusercontent.com/u/2344264?v=4&s=100)](https://github.com/jcramm)


## FAQ

- **How do I load inventory**
    - `ruby load_inventory.rb sound_supplier_1.csv`
    - Initially this just supports csv's and pipe delimited files specified with the `.pipe` file extension.
    - The order of the fields must conform to the samples provided in the repo.
- **How do I search inventory**
    - `ruby search_inventory.rb artist 'pink'`
    - Supported search terms inculde artist, album, released, and format.
- **How do I purchase inventory**
    - `ruby purchase.rb 155ea3b0ca4e5343be1c5e680a7cbfce`
    - The id provided here can be obtained from a search.


## Support

Reach out to me at one of the following places!

- Linkedin at <a href="https://www.linkedin.com/in/joel-cramm-7398227a/" target="_blank">`Linkedin`</a>


## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**

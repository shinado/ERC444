# ERC444
ERC444 is a meme standard for tokens used in afterlife. 

# Utilities
Afterlife is widely accepted in almost all cultures, serving as a foundational aspect of their worldviews and often reflecting their deepest values and ethical principles. 
In Christianity, Heaven and Hell are seen as eternal destinations, determined by divine judgment based on faith in Christ and moral conduct. In Chinese culture, the afterlife is a complex realm influenced by Confucian, Taoist, and Buddhist beliefs, emphasizing ancestral veneration and moral living to affect one's fate in the spiritual world and reincarnation.

# Send assets to people in afterlife
ERC444 is specifically designed for the purpose of being offered to ancestors, spirits, deities, or even departed celebrities (referred to as ghosts). The act of "burning" ERC444 assets essentially entails transferring these tokens to a unique address corresponding to the intended ghost recipient. This address is determined through the following calculation:
address = 0x44444444 + {md5 of {name+birthday+deathday}}

Once transferred to this address, the ERC44 assets become irreversibly removed from circulation, constituting a symbolic offering to the recipient in the Afterlife. This mechanism ensures that the tokens are permanently dedicated to the intended spiritual or commemorative purpose.

#ERC444 Notes
The ERC444 implementation here is a bit non-standard, where tokens are instead burned and minted repeatedly as per underlying / fractional transfers. This is a aspect of the concept's design is deliberate, with the goal of creating an NFT that has native fractionalization, liquidity and encourages some aspects of trading / engagement to farm unique trait sets.

#Licensing
This software is released under the MIT License.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

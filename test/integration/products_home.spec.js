/// <reference types="cypress" />

describe('Homepage', () => {

  it('Has products', () => {
    cy.visit('/')
    
    cy.contains('Super Loja')
    cy.getBySel('productCard').should('have.length.at.least', 10)
    cy.getBySel('price').should('exist')
    cy.getBySel('addToCart').should('exist')
  })

  it('Products can be added to cart', () => {
    cy.visit('/')
    cy.getBySel('productCard').first().within(() => {
      cy.getBySel('quantitySelect').select('2')
      cy.getBySel('addToCart').click()
    })
    cy.contains('Produto adicionado!')
  })
})

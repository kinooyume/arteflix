import React from 'react';
import { render, screen } from '@testing-library/react';
import { Main, Extra } from './CollectionInfo.bs.mjs';

describe('CollectionInfo', () => {
  describe('Main', () => {
    it('renders subtitle as h2 when provided', () => {
      render(<Main.make subtitle="My Subtitle" />);
      const heading = screen.getByRole('heading', { level: 2 });
      expect(heading).toBeTruthy();
      expect(heading.textContent).toBe('My Subtitle');
    });

    it('does not render h2 when subtitle is undefined', () => {
      render(<Main.make />);
      expect(screen.queryByRole('heading', { level: 2 })).toBeNull();
    });

    it('renders description as a paragraph when provided', () => {
      render(<Main.make description="Some description text" />);
      expect(screen.getByText('Some description text')).toBeTruthy();
    });

    it('does not render description paragraph when undefined', () => {
      const { container } = render(<Main.make />);
      const paragraphs = container.querySelectorAll('p');
      expect(paragraphs.length).toBe(0);
    });

    it('renders both subtitle and description together', () => {
      render(
        <Main.make subtitle="Title" description="Description" />
      );
      expect(screen.getByRole('heading', { level: 2 })).toBeTruthy();
      expect(screen.getByText('Description')).toBeTruthy();
    });
  });

  describe('Extra', () => {
    it('renders a paragraph for each item in the list', () => {
      const { container } = render(
        <Extra.make list={['Line 1', 'Line 2', 'Line 3']} />
      );
      const paragraphs = container.querySelectorAll('p');
      expect(paragraphs.length).toBe(3);
      expect(paragraphs[0].textContent).toBe('Line 1');
      expect(paragraphs[1].textContent).toBe('Line 2');
      expect(paragraphs[2].textContent).toBe('Line 3');
    });

    it('renders no paragraphs for an empty list', () => {
      const { container } = render(<Extra.make list={[]} />);
      const paragraphs = container.querySelectorAll('p');
      expect(paragraphs.length).toBe(0);
    });
  });
});

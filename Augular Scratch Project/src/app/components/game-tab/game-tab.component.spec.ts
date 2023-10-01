import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GameTabComponent } from './game-tab.component';

describe('GameTabComponent', () => {
  let component: GameTabComponent;
  let fixture: ComponentFixture<GameTabComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [GameTabComponent]
    });
    fixture = TestBed.createComponent(GameTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
